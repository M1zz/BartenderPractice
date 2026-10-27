import SwiftUI

/// Glass → Ingredients → Method → Garnish → Score.
struct PracticeFlowView: View {
    enum Step: Int, CaseIterable {
        case glass, ingredients, method, garnish

        var title: String {
            switch self {
            case .glass: return "잔 고르기"
            case .ingredients: return "술·재료 고르기"
            case .method: return "조주법 고르기"
            case .garnish: return "가니쉬 고르기"
            }
        }
    }

    let cocktail: Cocktail
    var examMode: Bool = false
    var onComplete: (Attempt, ScoreResult) -> Void = { _, _ in }

    @EnvironmentObject private var history: HistoryStore
    @Environment(\.dismiss) private var dismiss

    @State private var step: Step = .glass
    @State private var attempt = Attempt()
    @State private var result: ScoreResult?
    @State private var showRecipeHint = false

    var body: some View {
        Group {
            if let result, !examMode {
                ResultView(cocktail: cocktail, attempt: attempt, result: result,
                           onRetry: reset,
                           onDone: { dismiss() })
            } else {
                stepContent
            }
        }
        .navigationTitle(examMode ? "모의고사" : "실습")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !examMode {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showRecipeHint = true
                    } label: {
                        Image(systemName: "lightbulb")
                    }
                    .accessibilityLabel("레시피 힌트")
                }
            }
        }
        .sheet(isPresented: $showRecipeHint) {
            NavigationStack {
                RecipeDetailView(cocktail: cocktail, showsPracticeButton: false)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("닫기") { showRecipeHint = false }
                        }
                    }
            }
        }
    }

    // MARK: - Step layout

    private var stepContent: some View {
        VStack(spacing: 0) {
            header
            Divider()
            Group {
                switch step {
                case .glass: GlassPickerView(selection: $attempt.glass)
                case .ingredients: IngredientPickerView(attempt: $attempt)
                case .method: MethodPickerView(selection: $attempt.method)
                case .garnish: GarnishPickerView(selection: $attempt.garnish)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Divider()
            footer
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text("주문")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Text(cocktail.name)
                    .font(.title2.bold())
                Text(cocktail.englishName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            HStack(spacing: 6) {
                ForEach(Step.allCases, id: \.rawValue) { s in
                    Capsule()
                        .fill(s.rawValue <= step.rawValue ? Color.accentColor : Color.secondary.opacity(0.25))
                        .frame(height: 4)
                }
            }
            Text("\(step.rawValue + 1)/\(Step.allCases.count)  \(step.title)")
                .font(.subheadline.weight(.medium))
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }

    private var footer: some View {
        HStack {
            Button {
                withAnimation { step = Step(rawValue: step.rawValue - 1) ?? .glass }
            } label: {
                Label("이전", systemImage: "chevron.left")
            }
            .disabled(step == .glass)

            Spacer()

            if step == .garnish {
                Button(action: submit) {
                    Label("채점하기", systemImage: "checkmark.seal.fill")
                        .fontWeight(.semibold)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!canSubmit)
            } else {
                Button {
                    withAnimation { step = Step(rawValue: step.rawValue + 1) ?? .garnish }
                } label: {
                    Label("다음", systemImage: "chevron.right")
                        .labelStyle(.titleAndIcon)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!canAdvance)
            }
        }
        .padding()
    }

    private var canAdvance: Bool {
        switch step {
        case .glass: return attempt.glass != nil
        case .ingredients: return !attempt.items.isEmpty
        case .method: return attempt.method != nil
        case .garnish: return true
        }
    }

    private var canSubmit: Bool {
        attempt.glass != nil && !attempt.items.isEmpty && attempt.method != nil && attempt.garnish != nil
    }

    private func submit() {
        let scored = Scorer.score(attempt, against: cocktail)
        result = scored
        if !examMode {
            history.add(cocktail: cocktail, score: scored.breakdown, mode: .practice)
        }
        onComplete(attempt, scored)
    }

    private func reset() {
        attempt = Attempt()
        result = nil
        step = .glass
    }
}

// MARK: - Glass picker

struct GlassPickerView: View {
    @Binding var selection: Glass?

    private let columns = [GridItem(.adaptive(minimum: 110), spacing: 12)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(Glass.allCases) { glass in
                    let isSelected = selection == glass
                    Button {
                        selection = glass
                    } label: {
                        VStack(spacing: 8) {
                            GlassIcon(glass: glass, size: 56)
                                .foregroundStyle(isSelected ? Color.accentColor : Color.primary)
                            Text(glass.koreanName)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.primary)
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isSelected ? Color.accentColor.opacity(0.12) : Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isSelected ? Color.accentColor : .clear, lineWidth: 2)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}

// MARK: - Ingredient picker

struct IngredientPickerView: View {
    @Binding var attempt: Attempt
    @State private var searchText = ""

    var body: some View {
        List {
            if !attempt.items.isEmpty {
                Section("선택한 재료 (\(attempt.items.count))") {
                    ForEach(attempt.items, id: \.ingredient) { item in
                        selectedRow(item.ingredient)
                    }
                    .onDelete { offsets in
                        attempt.items.remove(atOffsets: offsets)
                    }
                    .onMove { from, to in
                        attempt.items.move(fromOffsets: from, toOffset: to)
                    }
                }
            }

            ForEach(IngredientCategory.allCases) { category in
                let ingredients = filtered(in: category)
                if !ingredients.isEmpty {
                    Section(category.rawValue) {
                        ForEach(ingredients) { ingredient in
                            Button {
                                withAnimation { attempt.toggle(ingredient) }
                            } label: {
                                HStack {
                                    Image(systemName: attempt.contains(ingredient) ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(attempt.contains(ingredient) ? Color.accentColor : Color.secondary)
                                    VStack(alignment: .leading) {
                                        Text(ingredient.koreanName)
                                        Text(ingredient.rawValue)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "재료 검색")
        .toolbar { EditButton() }
    }

    private func filtered(in category: IngredientCategory) -> [Ingredient] {
        Ingredient.allCases.filter { ingredient in
            guard ingredient.category == category else { return false }
            guard !searchText.isEmpty else { return true }
            return ingredient.koreanName.localizedCaseInsensitiveContains(searchText)
                || ingredient.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }

    private func selectedRow(_ ingredient: Ingredient) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ingredient.koreanName)
                Text(ingredient.rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Picker("용량", selection: Binding(
                get: { attempt.amount(for: ingredient) ?? .oneOz },
                set: { attempt.setAmount($0, for: ingredient) }
            )) {
                ForEach(Amount.allCases) { amount in
                    Text(amount.rawValue).tag(amount)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
        }
    }
}

// MARK: - Method picker

struct MethodPickerView: View {
    @Binding var selection: Method?

    var body: some View {
        List(Method.allCases) { method in
            Button {
                selection = method
            } label: {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: selection == method ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(selection == method ? Color.accentColor : Color.secondary)
                        .padding(.top, 2)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(method.koreanName).font(.headline)
                        Text(method.rawValue).font(.caption).foregroundStyle(.secondary)
                        Text(method.detail).font(.subheadline).foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Garnish picker

struct GarnishPickerView: View {
    @Binding var selection: Garnish?

    var body: some View {
        List(Garnish.allCases) { garnish in
            Button {
                selection = garnish
            } label: {
                HStack {
                    Image(systemName: selection == garnish ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(selection == garnish ? Color.accentColor : Color.secondary)
                    Text(garnish.rawValue)
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        PracticeFlowView(cocktail: CocktailData.all[0])
            .environmentObject(HistoryStore())
    }
}
