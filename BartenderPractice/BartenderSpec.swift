import Foundation
import LeeoKit

/// LeeoKit 계약 — 피드백 · 진단 · 정책 링크 · 로드맵의 단일 소스.
enum BartenderSpec: LeeoAppSpec {
    static let appName = "조주기능사실기"
    static let developerEmail = "leeo@kakao.com"

    /// 공용 피드백 허브. 권한은 BartenderPractice.entitlements 에 있다.
    static let feedback = LeeoFeedbackConfig(
        containerIdentifier: "iCloud.com.Ysoup.FeedbackHub",
        appIdentifier: "com.leeo.BartenderPractice"
    )

    static let analytics: any LeeoAnalytics = LeeoUsageAnalytics(spec: BartenderSpec.self)

    static let legal = LeeoLegalConfig(
        privacyURL: URL(string: "https://m1zz.github.io/BartenderPractice/privacy.html")!,
        supportURL: URL(string: "https://m1zz.github.io/BartenderPractice/support.html")!
    )

    static let monetization = LeeoMonetization.free

    static let dataPromise = LeeoDataPromise(
        onDevice: [NSLocalizedString("연습 기록과 점수", comment: "Data promise")],
        worksOffline: true
    )

    static var roadmap: [LeeoRoadmapItem] {[
        .init(id: "practice.wrongOnly", status: .planned,
              title: NSLocalizedString("틀린 칵테일만 다시 풀기", comment: "Roadmap item"),
              detail: NSLocalizedString("자주 틀리는 잔만 모아 집중해서 연습해요.", comment: "Roadmap item detail")),
        .init(id: "recipe.flashcards", status: .planned,
              title: NSLocalizedString("레시피 암기 카드", comment: "Roadmap item"),
              detail: NSLocalizedString("카드를 넘기며 재료와 용량을 빠르게 외워요.", comment: "Roadmap item detail")),
    ]}
}
