import SwiftUI

@main
struct TCA_NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            AppRoot.Scene(
                store: .init(
                    initialState: .init(),
                    reducer: { AppRoot() }
                )
            )
        }
    }
}
