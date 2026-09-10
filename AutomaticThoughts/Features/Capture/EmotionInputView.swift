import SwiftUI

struct EmotionInputView: View {
    @Binding var name: String
    @Binding var intensity: Int

    private let presets = ["Тревога", "Грусть", "Злость", "Стыд", "Вина", "Страх"]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Название эмоции", text: $name)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(presets, id: \.self) { preset in
                        Button(preset) {
                            name = preset
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Интенсивность")
                    Spacer()
                    Text("\(intensity)%")
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
                Slider(
                    value: Binding(
                        get: { Double(intensity) },
                        set: { intensity = Int($0.rounded()) }
                    ),
                    in: 0...100,
                    step: 1
                )
                .accessibilityValue("\(intensity) процентов")
            }
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    Form {
        Section("Эмоция") {
            EmotionInputView(
                name: .constant("Тревога"),
                intensity: .constant(65)
            )
        }
    }
}
