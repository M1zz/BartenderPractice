import SwiftUI
import LeeoKit

struct SettingsView: View {
    var body: some View {
        List {
            Section {
                NavigationLink(LeeoRoadmapText.entry) { LeeoRoadmapView<BartenderSpec>() }
            }
            Section("지원") {
                LeeoSupportSection<BartenderSpec>()
            }
        }
        .navigationTitle("설정")
    }
}
