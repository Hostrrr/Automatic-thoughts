import SwiftUI

struct EmotionListEditor: View {
    @Binding var emotions: [EmotionRating]

    var body: some View {
        ForEach($emotions) { $emotion in
            VStack(alignment: .leading, spacing: 8) {
                EmotionInputView(name: $emotion.name, intensity: $emotion.intensity)
                Button("Удалить эмоцию", role: .destructive) {
                    emotions.removeAll { $0.id == emotion.id }
                }
            }
        }

        Button("Добавить эмоцию") {
            emotions.append(EmotionRating())
        }
    }
}

#Preview {
    Form {
        Section("Эмоции") {
            EmotionListEditor(
                emotions: .constant([EmotionRating(name: "Тревога", intensity: 40)])
            )
        }
    }
}
