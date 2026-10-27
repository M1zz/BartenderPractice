import SwiftUI

/// Simulates the real practical exam: 3 cocktails, 7 minutes total.
struct MockExamView: View {
    struct Entry: Identifiable, Hashable {
        let cocktail: Cocktail
        var attempt: Attempt = Attempt()
        var result: ScoreResult?
        var id: String { cocktail.id }
    }

    @EnvironmentObject private var history: HistoryStore
    @Environment(\.dismiss) private var dismiss

    @State private var entries: [Entry] = CocktailData.randomSet().map { Entry(cocktail: $0, result: nil) }
    @State private var currentIndex = 0
    @State private var remaining = 7 * 60
    @State private var isFinished = false
    @State private var timedOut = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Group {
            if isFinished {
                summary
            } else {
                VStack(spacing: 0) {
                    examBar
                    PracticeFlowView(cocktail: entries[currentIndex].cocktail, examMode: true) { attempt, result in
                        entries[currentIndex].attempt = attempt
                        entries[currentIndex].result = result
                        advance()
                    }
                    .id(entries[currentIndex].id)
                }
            }
        }
        .navigationTitle("모의고사")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(!isFinished)
        .onReceive(timer) { _ in
            guard !isFinished else { return }
            if remaining > 0 {
                remaining -= 1
            } else {
                timedOut = true
                finish()
            }
        }
    }

    private var examBar: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(currentIndex + 1) / \(entries.count)잔")
                    .font(.body.weight(.semibold))
                Spacer()
                Label(timeString, systemImage: "timer")
                    .font(.body.monospacedDigit().weight(.semibold))
                    .foregroundStyle(remaining <= 60 ? Color.red : Color.primary)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                        Text(entry.cocktail.name)
                            .font(.body)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(
                                Capsule().fill(index == currentIndex ? Color.accentColor.opacity(0.2)
                                               : entry.result != nil ? Color.green.opacity(0.15)
                                               : Color.secondary.opacity(0.12))
                            )
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.secondarySystemBackground))
    }

    private var timeString: String {
        String(format: "%d:%02d", remaining / 60, remaining % 60)
    }

    private func advance() {
        if currentIndex + 1 < entries.count {
            currentIndex += 1
        } else {
            finish()
        }
    }

    private func finish() {
        guard !isFinished else { return }
        isFinished = true
        for entry in entries {
            history.add(cocktail: entry.cocktail,
                        score: entry.result?.breakdown ?? .zero,
                        mode: .exam)
        }
    }

    private var totalScore: Int {
        let sum = entries.map { $0.result?.breakdown.total ?? 0 }.reduce(0, +)
        return sum / max(entries.count, 1)
    }

    private var summary: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    ScoreHeader(breakdown: ScoreBreakdown(glass: 0, method: 0, ingredients: totalScore, garnish: 0))
                    if timedOut {
                        Label("제한시간 7분 초과 — 미완성 칵테일은 0점 처리", systemImage: "clock.badge.exclamationmark")
                            .font(.body)
                            .foregroundStyle(.red)
                    } else {
                        Text("소요시간 \(String(format: "%d:%02d", (7 * 60 - remaining) / 60, (7 * 60 - remaining) % 60))")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            } footer: {
                Text("3잔 평균 점수입니다. 실제 시험은 감독위원이 위생·동작·완성도까지 함께 평가합니다.")
                    .font(.body)
            }

            ForEach(entries) { entry in
                Section(entry.cocktail.name) {
                    if let result = entry.result {
                        NavigationLink(value: Route.examResult(cocktail: entry.cocktail,
                                                               attempt: entry.attempt,
                                                               result: result)) {
                            HStack {
                                Text(entry.cocktail.englishName)
                                Spacer()
                                Text("\(result.breakdown.total)점")
                                    .foregroundStyle(result.breakdown.isPassed ? Color.green : Color.red)
                                    .fontWeight(.semibold)
                            }
                        }
                        ForEach(result.checks.filter { $0.status != .correct }) { check in
                            IngredientCheckRow(check: check)
                        }
                    } else {
                        Label("미완성 — 0점", systemImage: "xmark.circle")
                            .foregroundStyle(.red)
                    }
                }
            }

            Section {
                Button {
                    restart()
                } label: {
                    Label("새 모의고사", systemImage: "arrow.counterclockwise")
                }
                Button {
                    dismiss()
                } label: {
                    Label("홈으로", systemImage: "house")
                }
            }
        }
    }

    private func restart() {
        entries = CocktailData.randomSet().map { Entry(cocktail: $0, result: nil) }
        currentIndex = 0
        remaining = 7 * 60
        timedOut = false
        isFinished = false
    }
}

#Preview {
    NavigationStack {
        MockExamView()
            .navigationDestination(for: Route.self) { $0.destination }
            .environmentObject(HistoryStore())
    }
}
