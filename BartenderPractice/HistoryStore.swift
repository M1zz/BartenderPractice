import Foundation
import Combine

struct PracticeRecord: Identifiable, Codable, Hashable {
    enum Mode: String, Codable { case practice, exam }

    let id: UUID
    let date: Date
    let cocktailID: String
    let score: ScoreBreakdown
    let mode: Mode

    var cocktail: Cocktail? { CocktailData.cocktail(id: cocktailID) }
}

@MainActor
final class HistoryStore: ObservableObject {
    @Published private(set) var records: [PracticeRecord] = []

    private let key = "practice.history.v1"
    private let maxRecords = 300

    init() {
        load()
    }

    func add(cocktail: Cocktail, score: ScoreBreakdown, mode: PracticeRecord.Mode) {
        let record = PracticeRecord(id: UUID(), date: Date(), cocktailID: cocktail.id,
                                    score: score, mode: mode)
        records.insert(record, at: 0)
        if records.count > maxRecords { records = Array(records.prefix(maxRecords)) }
        save()
    }

    func clear() {
        records = []
        save()
    }

    // MARK: Stats

    var averageScore: Int? {
        guard !records.isEmpty else { return nil }
        return records.map(\.score.total).reduce(0, +) / records.count
    }

    var passRate: Int? {
        guard !records.isEmpty else { return nil }
        let passed = records.filter { $0.score.isPassed }.count
        return passed * 100 / records.count
    }

    /// Cocktails with the lowest average score — good candidates for the next practice.
    func weakest(limit: Int = 5) -> [(cocktail: Cocktail, average: Int)] {
        var sums: [String: (total: Int, count: Int)] = [:]
        for record in records {
            var entry = sums[record.cocktailID] ?? (0, 0)
            entry.total += record.score.total
            entry.count += 1
            sums[record.cocktailID] = entry
        }
        return sums.compactMap { id, entry -> (Cocktail, Int)? in
            guard let cocktail = CocktailData.cocktail(id: id) else { return nil }
            return (cocktail, entry.total / entry.count)
        }
        .sorted { $0.1 < $1.1 }
        .prefix(limit)
        .map { (cocktail: $0.0, average: $0.1) }
    }

    // MARK: Persistence

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([PracticeRecord].self, from: data) else { return }
        records = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
