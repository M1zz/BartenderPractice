import SwiftUI

@main
struct BartenderPracticeApp: App {
    @StateObject private var history = HistoryStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(history)
                // List section headers default to footnote size; keep them at headline or larger.
                .headerProminence(.increased)
        }
    }
}
