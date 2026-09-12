import SwiftData
import SwiftUI

@main
struct AutomaticThoughtsApp: App {
    init() {
        AutomaticThoughtsShortcuts.updateAppShortcutParameters()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: ThoughtEntry.self)
    }
}
