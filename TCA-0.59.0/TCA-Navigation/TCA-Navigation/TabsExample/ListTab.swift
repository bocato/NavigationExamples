import ComposableArchitecture
import Foundation
import SwiftUI

struct ListItem: Codable, Equatable, Hashable, Identifiable {
    var id: String = UUID().uuidString
    var text: String
}

struct ListTab: Reducer {
    struct Destination: Reducer {
        enum State: Equatable {
            case addItem(AddItem.State)
            case itemDetail(ItemDetail.State)
        }
        
        enum Action: Equatable {
            case addItem(AddItem.Action)
            case itemDetail(ItemDetail.Action)
        }
        
        var body: some ReducerOf<Destination> {
            Scope(
                state: /State.addItem,
                action: /Action.addItem
            ) { AddItem() }
            Scope(
                state: /State.itemDetail,
                action: /Action.itemDetail
            ) { ItemDetail() }
        }
    }
    
    struct State: Equatable {
        var items: IdentifiedArrayOf<ListItem> = [
            .init(text: "Item 1"),
            .init(text: "Item 2"),
            .init(text: "Item 3"),
            .init(text: "Item 4")
        ]
        @PresentationState var destination: Destination.State?
    }
    
    enum Action: Equatable {
        case addItemTapped
        case itemDetailTapped(ListItem)
        case destination(PresentationAction<Destination.Action>)
    }
    
    var body: some ReducerOf<ListTab> {
        Reduce(reduceCore).ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }
    
    func reduceCore(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .addItemTapped:
            state.destination = .addItem(.init())
            return .none
        case let .itemDetailTapped(item):
            state.destination = .itemDetail(.init(item: item))
            return .none
        case let .destination(.presented(.addItem(.delegate(.itemSaved(newItem))))):
            state.items.append(newItem)
            state.destination = nil
            return .none
        case let .destination(.presented(.itemDetail(.delegate(.saveNewTextForItem(item, newText))))):
            state.items[id: item.id]?.text = newText
            state.destination = nil
            return .none
        case .destination(.dismiss):
            print("Dimissed")
            return .none
        case .destination:
            return .none
        }
    }
    
    struct Scene: View {
        let store: StoreOf<ListTab>
        
        var body: some View {
            NavigationStack {
                ContentView(store: store)
                    .sheet(
                        store: store.scope(state: \.$destination, action: { .destination($0) }),
                        state: /Destination.State.addItem,
                        action: Destination.Action.addItem
                    ) {
                        AddItem.Scene(store: $0)
                    }
            }
        }
        
        struct ContentView: View {
            let store: StoreOf<ListTab>
            var body: some View {
                WithViewStore(store, observe: \.items) { viewStore in
                    List {
                        ForEach(viewStore.state) { item in
                            Button(item.text) {
                                viewStore.send(.itemDetailTapped(item))
                            }
                        }
                    }
                    .navigationTitle("List Tab")
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                viewStore.send(.addItemTapped)
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    .navigationDestination(
                        store: store.scope(state: \.$destination, action: { .destination($0) }),
                        state: /Destination.State.itemDetail,
                        action: Destination.Action.itemDetail
                    ) {
                        ItemDetail.Scene(store: $0)
                    }
                }
            }
        }
    }
}
