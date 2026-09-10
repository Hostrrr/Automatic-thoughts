import Foundation

struct EmotionRating: Codable, Hashable, Identifiable {
    var id: UUID
    var name: String
    /// Intensity from 0 to 100.
    var intensity: Int

    init(id: UUID = UUID(), name: String = "", intensity: Int = 50) {
        self.id = id
        self.name = name
        self.intensity = min(100, max(0, intensity))
    }
}
