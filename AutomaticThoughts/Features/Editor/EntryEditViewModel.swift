import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class EntryEditViewModel {
    var event: String
    var automaticThought: String
    var emotions: [EmotionRating]
    var bodySensations: String
    var behavior: String
    var argumentsFor: String
    var argumentsAgainst: String
    var selectedDistortions: Set<String>
    var adaptiveResponse: String
    var emotionsAfter: [EmotionRating]
    var wasDraft: Bool

    init(entry: ThoughtEntry) {
        event = entry.event
        automaticThought = entry.automaticThought
        emotions = entry.emotions
        if emotions.isEmpty {
            emotions = [EmotionRating()]
        }
        bodySensations = entry.bodySensations
        behavior = entry.behavior
        argumentsFor = entry.argumentsFor
        argumentsAgainst = entry.argumentsAgainst
        selectedDistortions = Set(entry.cognitiveDistortion)
        adaptiveResponse = entry.adaptiveResponse
        emotionsAfter = entry.emotionsAfter
        wasDraft = entry.isDraft
    }

    var canSave: Bool {
        !trimmedThought.isEmpty
    }

    var navigationTitle: String {
        wasDraft ? "Дозаполнить" : "Запись"
    }

    func save(to entry: ThoughtEntry) {
        entry.event = event.trimmingCharacters(in: .whitespacesAndNewlines)
        entry.automaticThought = trimmedThought
        entry.emotions = sanitized(emotions)
        entry.bodySensations = bodySensations.trimmingCharacters(in: .whitespacesAndNewlines)
        entry.behavior = behavior.trimmingCharacters(in: .whitespacesAndNewlines)
        entry.argumentsFor = argumentsFor.trimmingCharacters(in: .whitespacesAndNewlines)
        entry.argumentsAgainst = argumentsAgainst.trimmingCharacters(in: .whitespacesAndNewlines)
        entry.cognitiveDistortion = CognitiveDistortion.allCases
            .map(\.rawValue)
            .filter { selectedDistortions.contains($0) }
        entry.adaptiveResponse = adaptiveResponse.trimmingCharacters(in: .whitespacesAndNewlines)
        entry.emotionsAfter = sanitized(emotionsAfter)
        entry.isDraft = false
        wasDraft = false
    }

    private var trimmedThought: String {
        automaticThought.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func sanitized(_ ratings: [EmotionRating]) -> [EmotionRating] {
        ratings.filter { !$0.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .map { rating in
                EmotionRating(
                    id: rating.id,
                    name: rating.name.trimmingCharacters(in: .whitespacesAndNewlines),
                    intensity: rating.intensity
                )
            }
    }
}
