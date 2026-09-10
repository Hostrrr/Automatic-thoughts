import SwiftData
import SwiftUI

enum PreviewSupport {
    @MainActor
    static func container(populated: Bool = false) -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: ThoughtEntry.self, configurations: configuration)
        if populated {
            insertSamples(into: container.mainContext)
        }
        return container
    }

    @MainActor
    static func insertSamples(into context: ModelContext) {
        let draft = ThoughtEntry(
            event: "Совещание с командой",
            automaticThought: "Я сейчас всё испорчу и меня сочтут некомпетентным.",
            emotions: [EmotionRating(name: "Тревога", intensity: 70)],
            isDraft: true
        )
        let complete = ThoughtEntry(
            event: "Сообщение без ответа",
            automaticThought: "Они специально меня игнорируют.",
            emotions: [EmotionRating(name: "Грусть", intensity: 55)],
            bodySensations: "Тяжесть в груди",
            behavior: "Перечитывал переписку",
            argumentsFor: "Обычно отвечают быстро",
            argumentsAgainst: "Могут быть заняты, это не про меня",
            cognitiveDistortion: [
                CognitiveDistortion.mindReading.rawValue,
                CognitiveDistortion.personalization.rawValue
            ],
            adaptiveResponse: "Я не знаю причины паузы. Могу подождать или спросить прямо.",
            emotionsAfter: [EmotionRating(name: "Грусть", intensity: 25)],
            isDraft: false
        )
        context.insert(draft)
        context.insert(complete)
    }
}
