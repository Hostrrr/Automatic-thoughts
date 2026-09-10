import AppIntents

struct OpenQuickCaptureIntent: AppIntent {
    static var title: LocalizedStringResource = "Новая мысль"
    static var description = IntentDescription("Открыть быстрый захват автоматической мысли.")
    static var openAppWhenRun = true

    @MainActor
    func perform() async throws -> some IntentResult {
        AppRouter.shared.openQuickCapture()
        return .result()
    }
}
