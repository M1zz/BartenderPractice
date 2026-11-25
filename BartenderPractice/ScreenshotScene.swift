#if DEBUG
import Foundation

/// 스토어 스크린샷용 — `-ScreenshotScene home|practice|result|exam|recipe` 로 실행하면 그 화면을 연다. DEBUG 전용.
enum ScreenshotScene {
    static var current: String? { UserDefaults.standard.string(forKey: "ScreenshotScene") }

    @MainActor
    static func prepare(history: HistoryStore) -> [Route]? {
        guard let scene = current else { return nil }
        seed(history)
        let pick = { (id: String) in CocktailData.cocktail(id: id)! }
        switch scene {
        case "practice": return [.practice(pick("margarita"))]
        case "exam": return [.mockExam]
        case "recipe": return [.recipeList, .recipe(pick("singapore-sling"))]
        case "result":
            let c = pick("manhattan")
            var a = Attempt(glass: c.glass, method: c.method, items: c.items, garnish: c.garnish)
            a.items[1] = RecipeItem(ingredient: c.items[1].ingredient, amount: .oneOz)
            return [.examResult(cocktail: c, attempt: a, result: Scorer.score(a, against: c))]
        default: return []
        }
    }

    @MainActor
    private static func seed(_ history: HistoryStore) {
        history.clear()
        let plan: [(String, Int)] = [("negroni", 100), ("margarita", 90), ("sidecar", 85), ("pousse-cafe", 45),
                                     ("singapore-sling", 55), ("manhattan", 95), ("mai-tai", 50), ("jindo", 80),
                                     ("dry-martini", 100), ("kir", 100), ("pousse-cafe", 60), ("mai-tai", 65)]
        for (id, total) in plan.reversed() {
            guard let c = CocktailData.cocktail(id: id) else { continue }
            var a = Attempt(glass: c.glass, method: c.method, items: c.items, garnish: c.garnish)
            if total < 100 { a.garnish = nil }
            if total < 80 { a.method = nil }
            if total < 60 { a.glass = nil }
            history.add(cocktail: c, score: Scorer.score(a, against: c).breakdown, mode: total == 85 ? .exam : .practice)
        }
    }
}
#endif
