import AppIntents
import Combine

/// 단축어가 연 화면을 홈 화면에 넘긴다.
@MainActor
final class ShortcutInbox: ObservableObject {
    static let shared = ShortcutInbox()
    @Published var pending: Route?
}

struct StartRandomPracticeIntent: AppIntent {
    static let title: LocalizedStringResource = "랜덤 실습 시작"
    static let openAppWhenRun = true

    @MainActor
    func perform() async throws -> some IntentResult {
        if let cocktail = CocktailData.all.randomElement() {
            ShortcutInbox.shared.pending = .practice(cocktail)
        }
        return .result()
    }
}

struct StartMockExamIntent: AppIntent {
    static let title: LocalizedStringResource = "모의고사 시작"
    static let openAppWhenRun = true

    @MainActor
    func perform() async throws -> some IntentResult {
        ShortcutInbox.shared.pending = .mockExam
        return .result()
    }
}

struct BartenderShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: StartRandomPracticeIntent(),
            phrases: ["\(.applicationName)에서 랜덤 실습", "\(.applicationName) 랜덤 실습 시작"],
            shortTitle: "랜덤 실습",
            systemImageName: "shuffle"
        )
        AppShortcut(
            intent: StartMockExamIntent(),
            phrases: ["\(.applicationName)에서 모의고사", "\(.applicationName) 모의고사 시작"],
            shortTitle: "모의고사",
            systemImageName: "timer"
        )
    }
}
