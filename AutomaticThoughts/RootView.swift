import SwiftData
import SwiftUI

struct RootView: View {
    @State private var router = AppRouter.shared
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        @Bindable var router = router
        TabView {
            JournalSplitView()
                .tabItem {
                    Label("Дневник", systemImage: "book.closed")
                }
        }
        .environment(router)
        .fullScreenCover(isPresented: $router.isQuickCapturePresented) {
            QuickCaptureView()
                .modelContainer(modelContext.container)
        }
        .onOpenURL { url in
            router.handleURL(url)
        }
    }
}

#Preview {
    RootView()
        .modelContainer(PreviewSupport.container())
        .environment(AppRouter.shared)
}
