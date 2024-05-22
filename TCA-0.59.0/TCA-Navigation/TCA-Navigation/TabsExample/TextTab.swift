import ComposableArchitecture
import Foundation
import SwiftUI

struct TextTab: Reducer {
    struct State: Equatable {}
    enum Action: Equatable {
        case openListTab
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .openListTab:
            return .none // Handled on parent
        }
    }
    
    struct Scene: View {
        let store: StoreOf<TextTab>
        
        var body: some View {
            WithViewStore(store, observe: { $0 } ) { viewStore in
                NavigationStack {
                    VStack {
                        Spacer()
                        Text("Text Tab")
                            .font(.largeTitle)
                        Spacer()
                        Button("Go to List Tab") {
                            viewStore.send(.openListTab)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        Spacer()
                    }
                    .navigationTitle("Text Tab")
                }
            }
        }
    }
}
