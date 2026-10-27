import SwiftUI

/// Every screen pushed onto the home NavigationStack.
/// All links use `NavigationLink(value:)` so the stack is driven by a single path.
enum Route: Hashable {
    case recipeList
    case recipe(Cocktail)
    case practice(Cocktail)
    case mockExam
    case examResult(cocktail: Cocktail, attempt: Attempt, result: ScoreResult)

    @ViewBuilder
    var destination: some View {
        switch self {
        case .recipeList:
            RecipeListView()
        case .recipe(let cocktail):
            RecipeDetailView(cocktail: cocktail)
        case .practice(let cocktail):
            PracticeFlowView(cocktail: cocktail)
        case .mockExam:
            MockExamView()
        case .examResult(let cocktail, let attempt, let result):
            ResultView(cocktail: cocktail, attempt: attempt, result: result,
                       onRetry: {}, onDone: {}, hidesBackButton: false)
        }
    }
}
