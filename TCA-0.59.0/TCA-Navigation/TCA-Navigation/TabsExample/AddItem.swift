import ComposableArchitecture
import Dependencies
import Foundation
import SwiftUI

struct AddItem: Reducer {
    struct State: Equatable {
        var itemText: String = ""
    }
    enum Action: Equatable {
        case updateItemText(String)
        case saveItemTapped
        case closeButtonTapped
        case delegate(Delegate)
        enum Delegate: Equatable {
            case itemSaved(ListItem)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .updateItemText(text):
            state.itemText = text
            return .none
        case .saveItemTapped:
            let item: ListItem = .init(
                text: state.itemText
            )
            return .send(.delegate(.itemSaved(item)))
        case .closeButtonTapped:
            return .run { _ in await dismiss() }
        case .delegate: // Handled on the parent
            return .none
        }
    }
    
    struct Scene: View {
        let store: StoreOf<AddItem>
        
        var body: some View {
            WithViewStore(store, observe: { $0 } ) { viewStore in
                NavigationStack {
                    VStack {
                        Spacer()
                        TextField(
                            "Item Name",
                            text: viewStore.binding(
                                get: \.itemText,
                                send: { .updateItemText($0) }
                            )
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        Spacer()
                        Button("Save") {
                            viewStore.send(.saveItemTapped)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        Spacer()
                    }
                    .toolbar {
                        ToolbarItem(placement: .secondaryAction) {
                            Button("Close") {
                                viewStore.send(.closeButtonTapped)
                            }
                        }
                    }
                    .navigationTitle("Add Item")
                }
            }
        }
    }
}
