import SwiftUI

struct ResultView: View {
    let cocktail: Cocktail
    let attempt: Attempt
    let result: ScoreResult
    var onRetry: () -> Void
    var onDone: () -> Void
    var hidesBackButton = true

    var body: some View {
        List {
            Section {
                ScoreHeader(breakdown: result.breakdown)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }

            Section("항목별 채점") {
                CompareRow(title: "잔",
                           points: result.breakdown.glass, max: ScoreBreakdown.glassMax,
                           chosen: attempt.glass?.koreanName ?? "—",
                           expected: cocktail.glass.koreanName)
                CompareRow(title: "조주법",
                           points: result.breakdown.method, max: ScoreBreakdown.methodMax,
                           chosen: attempt.method?.koreanName ?? "—",
                           expected: cocktail.method.koreanName)
                CompareRow(title: "가니쉬",
                           points: result.breakdown.garnish, max: ScoreBreakdown.garnishMax,
                           chosen: attempt.garnish?.rawValue ?? "—",
                           expected: cocktail.garnish.rawValue)
            }

            Section {
                ForEach(result.checks) { check in
                    IngredientCheckRow(check: check)
                }
            } header: {
                HStack {
                    Text("재료")
                    Spacer()
                    Text("\(result.breakdown.ingredients) / \(ScoreBreakdown.ingredientsMax)점")
                }
            } footer: {
                Text("재료 1개당 이름 50% + 용량 50%. 레시피에 없는 재료는 1개당 5점 감점.")
                    .font(.body)
            }

            if let tip = cocktail.tip {
                Section("팁") {
                    Label(tip, systemImage: "lightbulb")
                }
            }

            if hidesBackButton {
                Section {
                    Button(action: onRetry) {
                        Label("같은 칵테일 다시 하기", systemImage: "arrow.counterclockwise")
                    }
                    Button(action: onDone) {
                        Label("완료", systemImage: "checkmark")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .navigationTitle("채점 결과")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(hidesBackButton)
    }
}

struct ScoreHeader: View {
    let breakdown: ScoreBreakdown

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 12)
                Circle()
                    .trim(from: 0, to: CGFloat(breakdown.total) / 100)
                    .stroke(breakdown.isPassed ? Color.green : Color.red,
                            style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                VStack {
                    Text("\(breakdown.total)")
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                    Text("/ 100")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: 140, height: 140)

            Text(breakdown.isPassed ? "합격" : "불합격")
                .font(.title3.bold())
                .foregroundStyle(breakdown.isPassed ? Color.green : Color.red)
            Text("합격선 \(ScoreBreakdown.passLine)점")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
    }
}

struct CompareRow: View {
    let title: String
    let points: Int
    let max: Int
    let chosen: String
    let expected: String

    private var isCorrect: Bool { points == max }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(isCorrect ? Color.green : Color.red)
                Text(title).font(.headline)
                Spacer()
                Text("\(points) / \(max)점")
                    .font(.body.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
            if isCorrect {
                Text(expected).font(.body)
            } else {
                Text("선택: \(chosen)")
                    .font(.body)
                    .foregroundStyle(.red)
                Text("정답: \(expected)")
                    .font(.body)
                    .foregroundStyle(.green)
            }
        }
        .padding(.vertical, 4)
    }
}

struct IngredientCheckRow: View {
    let check: IngredientCheck

    private var icon: (name: String, color: Color) {
        switch check.status {
        case .correct: return ("checkmark.circle.fill", .green)
        case .wrongAmount: return ("exclamationmark.triangle.fill", .orange)
        case .missing: return ("minus.circle.fill", .red)
        case .extra: return ("xmark.circle.fill", .red)
        }
    }

    private var detail: String {
        switch check.status {
        case .correct:
            return check.expected?.rawValue ?? ""
        case .wrongAmount:
            return "선택 \(check.chosen?.rawValue ?? "") → 정답 \(check.expected?.rawValue ?? "")"
        case .missing:
            return "빠짐 (정답 \(check.expected?.rawValue ?? ""))"
        case .extra:
            return "레시피에 없는 재료 (−5점)"
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon.name)
                .foregroundStyle(icon.color)
                .padding(.top, 2)
            VStack(alignment: .leading, spacing: 2) {
                Text(check.ingredient.koreanName)
                Text(detail)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

private func sampleAttempt() -> Attempt {
    var attempt = Attempt()
    attempt.glass = .cocktail
    attempt.method = .shake
    attempt.items = [RecipeItem(ingredient: .bourbon, amount: .oneHalfOz),
                     RecipeItem(ingredient: .sweetVermouth, amount: .oneOz),
                     RecipeItem(ingredient: .campari, amount: .halfOz)]
    attempt.garnish = .cherry
    return attempt
}

#Preview {
    NavigationStack {
        ResultView(cocktail: CocktailData.all[0],
                   attempt: sampleAttempt(),
                   result: Scorer.score(sampleAttempt(), against: CocktailData.all[0]),
                   onRetry: {}, onDone: {})
    }
}
