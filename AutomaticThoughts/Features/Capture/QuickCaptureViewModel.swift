import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class QuickCaptureViewModel {
    var event = ""
    var automaticThought = ""
    var emotionName = ""
    var emotionIntensity = 50

    var canSave: Bool {
        !trimmedThought.isEmpty
    }

    func save(into context: ModelContext) throws {
        guard canSave else { return }

        var emotions: [EmotionRating] = []
        let name = emotionName.trimmingCharacters(in: .whitespacesAndNewlines)
        if !name.isEmpty {
            emotions.append(EmotionRating(name: name, intensity: emotionIntensity))
        }

        let entry = ThoughtEntry(
            event: event.trimmingCharacters(in: .whitespacesAndNewlines),
            automaticThought: trimmedThought,
            emotions: emotions,
            isDraft: true
        )
        context.insert(entry)
        try context.save()
    }

    private var trimmedThought: String {
        automaticThought.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
