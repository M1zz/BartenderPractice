# 조주기능사 실기 연습 (BartenderPractice)

SwiftUI · iOS 17+ · Xcode 16+ (file-system-synchronized groups 사용)

## 실행
1. `BartenderPractice.xcodeproj` 열기
2. Signing & Capabilities에서 Team 선택
3. 시뮬레이터 또는 기기에서 Run

## 구조
| 파일 | 역할 |
|---|---|
| `Models.swift` | Base / Glass / Method / Garnish / Amount / Ingredient / Cocktail 모델 |
| `CocktailData.swift` | 2025 NCS 기준 표준 레시피 40종 |
| `Scoring.swift` | Attempt → ScoreBreakdown 채점 (잔 20 · 조주법 20 · 재료 40 · 가니쉬 20) |
| `PracticeFlowView.swift` | 잔 → 재료 → 조주법 → 가니쉬 4단계 선택 플로우 |
| `ResultView.swift` | 채점 결과 + 정답 비교 |
| `MockExamView.swift` | 3잔 · 7분 모의고사 |
| `RecipeViews.swift` | 레시피 목록/상세 |
| `HistoryStore.swift` | UserDefaults 기반 연습 기록 |
| `GlassShape.swift` | 잔 실루엣 라인아트 |

## 채점 기준
- 잔 20점, 조주법 20점, 가니쉬 20점: 정답과 일치하면 만점, 아니면 0점
- 재료 40점: 재료 1개당 이름 50% + 용량 50%, 레시피에 없는 재료는 1개당 −5점
- 합격선 60점

## 레시피 출처
(사)한국베버리지마스터협회 "실기40칵테일(2025)" 및 공개 자료를 기준으로 정리.
시험 전 한국산업인력공단 공개문제의 최신 레시피와 대조하세요.
