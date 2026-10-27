import SwiftUI

struct RecipeListView: View {
    @State private var searchText = ""
    @State private var selectedBase: Base? = nil

    private var filtered: [Cocktail] {
        CocktailData.all.filter { cocktail in
            if let selectedBase, cocktail.base != selectedBase { return false }
            guard !searchText.isEmpty else { return true }
            return cocktail.name.localizedCaseInsensitiveContains(searchText)
                || cocktail.englishName.localizedCaseInsensitiveContains(searchText)
                || cocktail.items.contains { $0.ingredient.koreanName.localizedCaseInsensitiveContains(searchText)
                                              || $0.ingredient.rawValue.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        List {
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        baseChip(nil, title: "전체")
                        ForEach(Base.allCases) { base in
                            baseChip(base, title: base.rawValue)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            }

            Section("\(filtered.count)종") {
                ForEach(filtered) { cocktail in
                    NavigationLink(value: cocktail) {
                        CocktailRow(cocktail: cocktail)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "칵테일 또는 재료 검색")
        .navigationTitle("레시피 40")
        .navigationDestination(for: Cocktail.self) { cocktail in
            RecipeDetailView(cocktail: cocktail)
        }
    }

    private func baseChip(_ base: Base?, title: String) -> some View {
        let isSelected = selectedBase == base
        return Button {
            selectedBase = base
        } label: {
            Text(title)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Capsule().fill(isSelected ? Color.accentColor : Color.secondary.opacity(0.15)))
                .foregroundStyle(isSelected ? Color.white : Color.primary)
        }
        .buttonStyle(.plain)
    }
}

struct CocktailRow: View {
    let cocktail: Cocktail

    var body: some View {
        HStack(spacing: 12) {
            GlassIcon(glass: cocktail.glass, size: 36, lineWidth: 1.5)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 2) {
                Text(cocktail.name).font(.headline)
                Text("\(cocktail.englishName) · \(cocktail.base.rawValue) · \(cocktail.method.rawValue)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct RecipeDetailView: View {
    let cocktail: Cocktail
    var showsPracticeButton = true

    var body: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    GlassIcon(glass: cocktail.glass, size: 96, lineWidth: 2.5)
                        .foregroundStyle(Color.accentColor)
                    Text(cocktail.name).font(.title.bold())
                    Text(cocktail.englishName).foregroundStyle(.secondary)
                    Text("\(cocktail.base.rawValue) 베이스")
                        .font(.caption)
                        .padding(.horizontal, 10).padding(.vertical, 4)
                        .background(Capsule().fill(Color.secondary.opacity(0.15)))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .listRowBackground(Color.clear)
            }

            Section("잔 · 조주법") {
                LabeledContent("Glass", value: cocktail.glass.koreanName)
                LabeledContent("Method", value: cocktail.method.koreanName)
            }

            Section("재료") {
                ForEach(Array(cocktail.items.enumerated()), id: \.offset) { index, item in
                    HStack {
                        Text("\(index + 1)")
                            .font(.caption.monospacedDigit())
                            .foregroundStyle(.secondary)
                            .frame(width: 18)
                        VStack(alignment: .leading) {
                            Text(item.ingredient.koreanName)
                            Text(item.ingredient.rawValue)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(item.amount.rawValue).fontWeight(.medium)
                            if let note = item.note {
                                Text(note).font(.caption).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }

            Section("가니쉬") {
                Text(cocktail.garnish.rawValue)
            }

            if let tip = cocktail.tip {
                Section("팁") {
                    Label(tip, systemImage: "lightbulb")
                }
            }

            if showsPracticeButton {
                Section {
                    NavigationLink {
                        PracticeFlowView(cocktail: cocktail)
                    } label: {
                        Label("이 칵테일로 실습하기", systemImage: "play.fill")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
        .navigationTitle(cocktail.englishName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecipeListView()
            .environmentObject(HistoryStore())
    }
}
