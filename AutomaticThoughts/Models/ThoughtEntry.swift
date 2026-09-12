import Foundation
import SwiftData

@Model
final class ThoughtEntry {
    @Attribute(.unique) var id: UUID
    var createdAt: Date
    var event: String
    var automaticThought: String
    var emotions: [EmotionRating]
    var bodySensations: String
    var behavior: String
    var argumentsFor: String
    var argumentsAgainst: String
    var cognitiveDistortion: [String]
    var adaptiveResponse: String
    var emotionsAfter: [EmotionRating]
    var isDraft: Bool

    init(
        id: UUID = UUID(),
        createdAt: Date = .now,
        event: String = "",
        automaticThought: String = "",
        emotions: [EmotionRating] = [],
        bodySensations: String = "",
        behavior: String = "",
        argumentsFor: String = "",
        argumentsAgainst: String = "",
        cognitiveDistortion: [String] = [],
        adaptiveResponse: String = "",
        emotionsAfter: [EmotionRating] = [],
        isDraft: Bool = true
    ) {
        self.id = id
        self.createdAt = createdAt
        self.event = event
        self.automaticThought = automaticThought
        self.emotions = emotions
        self.bodySensations = bodySensations
        self.behavior = behavior
        self.argumentsFor = argumentsFor
        self.argumentsAgainst = argumentsAgainst
        self.cognitiveDistortion = cognitiveDistortion
        self.adaptiveResponse = adaptiveResponse
        self.emotionsAfter = emotionsAfter
        self.isDraft = isDraft
    }
}
