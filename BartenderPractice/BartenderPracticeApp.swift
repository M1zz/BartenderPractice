import SwiftUI

@main
struct BartenderPracticeApp: App {
    @StateObject private var history = HistoryStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(history)
        }
    }
}
