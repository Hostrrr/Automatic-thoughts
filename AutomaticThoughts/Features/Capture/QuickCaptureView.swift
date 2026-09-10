import SwiftData
import SwiftUI

struct QuickCaptureView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = QuickCaptureViewModel()
    @State private var errorMessage: String?

    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            Form {
                Section("Ситуация") {
                    TextField("Что произошло?", text: $viewModel.event, axis: .vertical)
                        .lineLimit(2...6)
                }

                Section("Автоматическая мысль") {
                    TextField("Какая мысль пришла в голову?", text: $viewModel.automaticThought, axis: .vertical)
                        .lineLimit(2...6)
                }

                Section("Эмоция") {
                    EmotionInputView(
                        name: $viewModel.emotionName,
                        intensity: $viewModel.emotionIntensity
                    )
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Новая мысль")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Закрыть") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        save()
                    }
                    .disabled(!viewModel.canSave)
                }
            }
            .alert("Не удалось сохранить", isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage ?? "")
            }
        }
    }

    private func save() {
        do {
            try viewModel.save(into: modelContext)
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    QuickCaptureView()
        .modelContainer(PreviewSupport.container())
}
