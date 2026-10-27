import Foundation

/// What the user assembled during one practice run.
struct Attempt: Codable, Hashable {
    var glass: Glass? = nil
    var method: Method? = nil
    var items: [RecipeItem] = []
    var garnish: Garnish? = nil

    func contains(_ ingredient: Ingredient) -> Bool {
        items.contains { $0.ingredient == ingredient }
    }

    func amount(for ingredient: Ingredient) -> Amount? {
        items.first { $0.ingredient == ingredient }?.amount
    }

    mutating func toggle(_ ingredient: Ingredient) {
        if let index = items.firstIndex(where: { $0.ingredient == ingredient }) {
            items.remove(at: index)
        } else {
            items.append(RecipeItem(ingredient: ingredient, amount: .oneOz))
        }
    }

    mutating func setAmount(_ amount: Amount, for ingredient: Ingredient) {
        guard let index = items.firstIndex(where: { $0.ingredient == ingredient }) else { return }
        items[index] = RecipeItem(ingredient: ingredient, amount: amount)
    }
}

struct ScoreBreakdown: Codable, Hashable {
    static let glassMax = 20
    static let methodMax = 20
    static let ingredientsMax = 40
    static let garnishMax = 20
    static let passLine = 60

    var glass: Int
    var method: Int
    var ingredients: Int
    var garnish: Int

    var total: Int { glass + method + ingredients + garnish }
    var isPassed: Bool { total >= Self.passLine }

    static let zero = ScoreBreakdown(glass: 0, method: 0, ingredients: 0, garnish: 0)
}

struct IngredientCheck: Identifiable, Hashable {
    enum Status: Hashable {
        case correct        // ingredient + amount match
        case wrongAmount    // ingredient right, amount off
        case missing        // required but not chosen
        case extra          // chosen but not in recipe
    }

    let ingredient: Ingredient
    let expected: Amount?
    let chosen: Amount?
    let status: Status

    var id: String { ingredient.rawValue }
}

struct ScoreResult: Hashable {
    let breakdown: ScoreBreakdown
    let checks: [IngredientCheck]
}

enum Scorer {

    static func score(_ attempt: Attempt, against cocktail: Cocktail) -> ScoreResult {
        let glassScore = attempt.glass == cocktail.glass ? ScoreBreakdown.glassMax : 0
        let methodScore = attempt.method == cocktail.method ? ScoreBreakdown.methodMax : 0
        let garnishScore = attempt.garnish == cocktail.garnish ? ScoreBreakdown.garnishMax : 0

        var checks: [IngredientCheck] = []
        var earned = 0.0

        for required in cocktail.items {
            if let chosen = attempt.amount(for: required.ingredient) {
                if chosen == required.amount {
                    earned += 1.0
                    checks.append(.init(ingredient: required.ingredient, expected: required.amount,
                                        chosen: chosen, status: .correct))
                } else {
                    earned += 0.5
                    checks.append(.init(ingredient: required.ingredient, expected: required.amount,
                                        chosen: chosen, status: .wrongAmount))
                }
            } else {
                checks.append(.init(ingredient: required.ingredient, expected: required.amount,
                                    chosen: nil, status: .missing))
            }
        }

        let requiredSet = Set(cocktail.items.map(\.ingredient))
        let extras = attempt.items.filter { !requiredSet.contains($0.ingredient) }
        for extra in extras {
            checks.append(.init(ingredient: extra.ingredient, expected: nil,
                                chosen: extra.amount, status: .extra))
        }

        let ratio = cocktail.items.isEmpty ? 0 : earned / Double(cocktail.items.count)
        let penalty = extras.count * 5
        let ingredientScore = max(0, Int((ratio * Double(ScoreBreakdown.ingredientsMax)).rounded()) - penalty)

        let breakdown = ScoreBreakdown(glass: glassScore, method: methodScore,
                                       ingredients: ingredientScore, garnish: garnishScore)
        return ScoreResult(breakdown: breakdown, checks: checks)
    }
}
