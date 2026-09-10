import Foundation
import Observation

@MainActor
@Observable
final class AppRouter {
    static let shared = AppRouter()

    var isQuickCapturePresented = false
    var selectedEntryID: UUID?

    private init() {}

    func openQuickCapture() {
        isQuickCapturePresented = true
    }

    func handleURL(_ url: URL) {
        guard url.scheme == "thoughts" else { return }
        let host = url.host
        let path = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        if host == "capture" || path == "capture" {
            openQuickCapture()
        }
    }
}
