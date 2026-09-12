import SwiftUI

struct DistortionPicker: View {
    @Binding var selected: Set<String>

    var body: some View {
        ForEach(CognitiveDistortion.allCases) { distortion in
            Toggle(distortion.title, isOn: Binding(
                get: { selected.contains(distortion.rawValue) },
                set: { isOn in
                    if isOn {
                        selected.insert(distortion.rawValue)
                    } else {
                        selected.remove(distortion.rawValue)
                    }
                }
            ))
        }
    }
}

#Preview {
    Form {
        Section("Когнитивные искажения") {
            DistortionPicker(selected: .constant([CognitiveDistortion.catastrophizing.rawValue]))
        }
    }
}
