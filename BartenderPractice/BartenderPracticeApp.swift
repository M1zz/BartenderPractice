import SwiftUI
import LeeoKit

@main
struct BartenderPracticeApp: App {
    @StateObject private var history = HistoryStore()

    init() { LeeoKit.bootstrap(BartenderSpec.self) }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(history)
                // List section headers default to footnote size; keep them at headline or larger.
                .headerProminence(.increased)
                .leeoCelebrations(appName: BartenderSpec.displayName)
        }
    }
}
