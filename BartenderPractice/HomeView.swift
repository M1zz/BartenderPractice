import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var history: HistoryStore
    @State private var randomCocktail: Cocktail?
    @State private var showClearConfirm = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        randomCocktail = CocktailData.all.randomElement()
                    } label: {
                        ModeRow(icon: "shuffle", color: .orange,
                                title: "랜덤 실습",
                                subtitle: "40종 중 한 잔을 무작위로 주문받습니다")
                    }

                    NavigationLink {
                        RecipeListView()
                    } label: {
                        ModeRow(icon: "list.bullet.rectangle", color: .blue,
                                title: "칵테일 골라서 실습",
                                subtitle: "레시피를 보고 원하는 칵테일로 연습")
                    }

                    NavigationLink {
                        MockExamView()
                    } label: {
                        ModeRow(icon: "timer", color: .red,
                                title: "모의고사",
                                subtitle: "실제 시험처럼 3잔 · 7분")
                    }
                } header: {
                    Text("실습")
                } footer: {
                    Text("잔 → 술·재료 → 조주법 → 가니쉬 순서로 고르면 채점합니다.")
                }

                if !history.records.isEmpty {
                    Section("나의 기록") {
                        HStack {
                            StatTile(title: "평균", value: "\(history.averageScore ?? 0)점")
                            StatTile(title: "합격률", value: "\(history.passRate ?? 0)%")
                            StatTile(title: "연습 횟수", value: "\(history.records.count)회")
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    }

                    let weak = history.weakest(limit: 3)
                    if !weak.isEmpty {
                        Section("보강이 필요한 칵테일") {
                            ForEach(weak, id: \.cocktail.id) { item in
                                NavigationLink {
                                    PracticeFlowView(cocktail: item.cocktail)
                                } label: {
                                    HStack {
                                        CocktailRow(cocktail: item.cocktail)
                                        Spacer()
                                        Text("평균 \(item.average)점")
                                            .font(.caption)
                                            .foregroundStyle(item.average >= ScoreBreakdown.passLine ? Color.green : Color.red)
                                    }
                                }
                            }
                        }
                    }

                    Section("최근 연습") {
                        ForEach(history.records.prefix(10)) { record in
                            if let cocktail = record.cocktail {
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(cocktail.name)
                                        Text(record.date, format: .dateTime.month().day().hour().minute())
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    if record.mode == .exam {
                                        Text("모의고사")
                                            .font(.caption2)
                                            .padding(.horizontal, 6).padding(.vertical, 2)
                                            .background(Capsule().fill(Color.red.opacity(0.15)))
                                    }
                                    Text("\(record.score.total)점")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(record.score.isPassed ? Color.green : Color.red)
                                }
                            }
                        }
                        Button(role: .destructive) {
                            showClearConfirm = true
                        } label: {
                            Label("기록 초기화", systemImage: "trash")
                        }
                    }
                }

                Section {
                    NavigationLink {
                        RecipeListView()
                    } label: {
                        Label("표준 레시피 40종 보기", systemImage: "book")
                    }
                } footer: {
                    Text("2025년 NCS 신기준 조주기능사 실기 표준 레시피를 기준으로 합니다. 시험 전 반드시 한국산업인력공단 공개문제의 최신 레시피를 확인하세요.")
                }
            }
            .navigationTitle("조주기능사 실기 연습")
            .navigationDestination(item: $randomCocktail) { cocktail in
                PracticeFlowView(cocktail: cocktail)
            }
            .confirmationDialog("모든 연습 기록을 삭제할까요?", isPresented: $showClearConfirm, titleVisibility: .visible) {
                Button("삭제", role: .destructive) { history.clear() }
                Button("취소", role: .cancel) {}
            }
        }
    }
}

struct ModeRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(RoundedRectangle(cornerRadius: 10).fill(color))
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.headline).foregroundStyle(.primary)
                Text(subtitle).font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}

struct StatTile: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3.bold().monospacedDigit())
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary.opacity(0.1)))
    }
}

#Preview {
    HomeView()
        .environmentObject(HistoryStore())
}
