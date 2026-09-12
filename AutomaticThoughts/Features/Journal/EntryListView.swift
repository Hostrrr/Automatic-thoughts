import SwiftData
import SwiftUI

struct EntryListView: View {
    @Binding var selection: UUID?
    @Query(sort: \ThoughtEntry.createdAt, order: .reverse) private var entries: [ThoughtEntry]
    @Environment(\.modelContext) private var modelContext
    @Environment(AppRouter.self) private var router

    private var drafts: [ThoughtEntry] {
        entries.filter(\.isDraft)
    }

    private var completed: [ThoughtEntry] {
        entries.filter { !$0.isDraft }
    }

    var body: some View {
        Group {
            if entries.isEmpty {
                ContentUnavailableView(
                    "Пока нет записей",
                    systemImage: "text.quote",
                    description: Text("Нажмите +, чтобы быстро зафиксировать мысль.")
                )
            } else {
                List(selection: $selection) {
                    if !drafts.isEmpty {
                        Section("Черновики") {
                            ForEach(drafts) { entry in
                                NavigationLink(value: entry.id) {
                                    EntryRowView(entry: entry)
                                }
                                .tag(entry.id)
                            }
                            .onDelete { offsets in
                                delete(from: drafts, at: offsets)
                            }
                        }
                    }

                    if !completed.isEmpty {
                        Section("Записи") {
                            ForEach(completed) { entry in
                                NavigationLink(value: entry.id) {
                                    EntryRowView(entry: entry)
                                }
                                .tag(entry.id)
                            }
                            .onDelete { offsets in
                                delete(from: completed, at: offsets)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Мысли")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    router.openQuickCapture()
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Новая мысль")
            }
        }
    }

    private func delete(from subset: [ThoughtEntry], at offsets: IndexSet) {
        for index in offsets {
            let entry = subset[index]
            if selection == entry.id {
                selection = nil
            }
            modelContext.delete(entry)
        }
        try? modelContext.save()
    }
}

#Preview {
    EntryListPreview()
}

private struct EntryListPreview: View {
    @State private var selection: UUID?

    var body: some View {
        NavigationStack {
            EntryListView(selection: $selection)
        }
        .modelContainer(PreviewSupport.container(populated: true))
        .environment(AppRouter.shared)
    }
}
