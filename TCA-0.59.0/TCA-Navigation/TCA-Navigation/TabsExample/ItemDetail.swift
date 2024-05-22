import ComposableArchitecture
import Dependencies
import Foundation
import SwiftUI

struct ItemDetail: Reducer {
    struct State: Codable, Equatable, Hashable {
        let item: ListItem
        var itemText: String = ""
        
        init(item: ListItem) {
            self.item = item
            self.itemText = item.text
        }
    }
    
    enum Action: Equatable {
        case updateItemText(String)
        case saveChangesTapped
        case delegate(Delegate)
        enum Delegate: Equatable {
            case saveNewTextForItem(ListItem, String)
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .updateItemText(text):
            state.itemText = text
            return .none
        case .saveChangesTapped:
            let item = state.item
            let newText = state.itemText
            return .send(.delegate(.saveNewTextForItem(item, newText)))
        case .delegate: // Handled on the parent
            return .none
        }
    }
    
    struct Scene: View {
        let store: StoreOf<ItemDetail>
        
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
                        Button("Save Changes") {
                            viewStore.send(.saveChangesTapped)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        Spacer()
                    }
                    .navigationTitle("Item Details")
                }
            }
        }
    }
}
