import SwiftData
import SwiftUI

struct JournalSplitView: View {
    @Environment(AppRouter.self) private var router
    @Query(sort: \ThoughtEntry.createdAt, order: .reverse) private var entries: [ThoughtEntry]

    // Shows the list first on compact-width scenes (typical iPhone).
    @State private var preferredCompactColumn = NavigationSplitViewColumn.sidebar

    var body: some View {
        // TODO(iOS 27.1): when the Xcode 27.1 SDK is stable, revisit Duo ArrangementView
        // and reserved hinge regions. NavigationSplitView + size classes should already
        // adapt to a regular-width inner display without hardcoded breakpoints.
        @Bindable var router = router
        NavigationSplitView(preferredCompactColumn: $preferredCompactColumn) {
            EntryListView(selection: $router.selectedEntryID)
        } detail: {
            if let selectedID = router.selectedEntryID,
               let entry = entries.first(where: { $0.id == selectedID }) {
                EntryEditView(entry: entry)
                    .id(entry.id)
            } else {
                ContentUnavailableView(
                    "Выберите запись",
                    systemImage: "text.book.closed",
                    description: Text("Выберите мысль слева или создайте новую.")
                )
            }
        }
    }
}

#Preview {
    JournalSplitView()
        .modelContainer(PreviewSupport.container(populated: true))
        .environment(AppRouter.shared)
}
