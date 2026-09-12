import AppIntents

struct AutomaticThoughtsShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenQuickCaptureIntent(),
            phrases: [
                "Новая мысль в \(.applicationName)",
                "Записать мысль в \(.applicationName)",
                "Быстрый захват в \(.applicationName)"
            ],
            shortTitle: "Новая мысль",
            systemImageName: "plus.circle"
        )
    }

    static var shortcutTileColor: ShortcutTileColor = .teal
}
