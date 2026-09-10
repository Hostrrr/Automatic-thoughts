import SwiftData
import SwiftUI

struct EntryEditView: View {
    let entry: ThoughtEntry
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: EntryEditViewModel
    @State private var errorMessage: String?

    init(entry: ThoughtEntry) {
        self.entry = entry
        _viewModel = State(initialValue: EntryEditViewModel(entry: entry))
    }

    var body: some View {
        @Bindable var viewModel = viewModel
        Form {
            Section("Ситуация") {
                TextField("Что произошло?", text: $viewModel.event, axis: .vertical)
                    .lineLimit(2...8)
            }

            Section("Автоматическая мысль") {
                TextField("Какая мысль пришла в голову?", text: $viewModel.automaticThought, axis: .vertical)
                    .lineLimit(2...8)
            }

            Section("Эмоции") {
                EmotionListEditor(emotions: $viewModel.emotions)
            }

            Section("Телесные ощущения") {
                TextField("Что ощущалось в теле?", text: $viewModel.bodySensations, axis: .vertical)
                    .lineLimit(2...6)
            }

            Section("Поведение") {
                TextField("Что вы сделали или захотели сделать?", text: $viewModel.behavior, axis: .vertical)
                    .lineLimit(2...6)
            }

            Section("Аргументы за мысль") {
                TextField("Что говорит в пользу этой мысли?", text: $viewModel.argumentsFor, axis: .vertical)
                    .lineLimit(3...8)
            }

            Section("Аргументы против") {
                TextField("Что говорит против этой мысли?", text: $viewModel.argumentsAgainst, axis: .vertical)
                    .lineLimit(3...8)
            }

            Section("Когнитивные искажения") {
                DistortionPicker(selected: $viewModel.selectedDistortions)
            }

            Section("Адаптивный ответ") {
                TextField("Сбалансированный ответ себе", text: $viewModel.adaptiveResponse, axis: .vertical)
                    .lineLimit(3...10)
            }

            Section("Эмоции после проработки") {
                EmotionListEditor(emotions: $viewModel.emotionsAfter)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
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

    private func save() {
        viewModel.save(to: entry)
        do {
            try modelContext.save()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    EntryEditPreview()
}

private struct EntryEditPreview: View {
    private let container = PreviewSupport.container(populated: true)

    var body: some View {
        NavigationStack {
            if let entry = try? container.mainContext.fetch(FetchDescriptor<ThoughtEntry>()).first {
                EntryEditView(entry: entry)
            }
        }
        .modelContainer(container)
    }
}
