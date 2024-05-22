import ComposableArchitecture
import Foundation
import SwiftUI

struct AppRoot: Reducer {
    struct Tabs: Reducer {
        enum ID: Int {
            case textTab
            case listTab
        }
        
        struct State: Equatable {
            var textTab: TextTab.State = .init()
            var listTab: ListTab.State = .init()
        }
        enum Action: Equatable {
            case textTab(TextTab.Action)
            case listTab(ListTab.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(
                state: \.textTab,
                action: /Action.textTab,
                child: { TextTab() }
            )
            Scope(
                state: \.listTab,
                action: /Action.listTab,
                child: { ListTab() }
            )
        }
    }
    
    struct State: Equatable {
        var selectedTab: Tabs.ID = .textTab
        var tabsState: Tabs.State = .init()
    }
    
    enum Action: Equatable {
        case updateSelectedTab(Tabs.ID)
        case tabs(Tabs.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce(reduceCore)
        Scope(
            state: \.tabsState,
            action: /Action.tabs,
            child: { Tabs() }
        )
    }
    
    func reduceCore(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .updateSelectedTab(index):
            state.selectedTab = index
            return .none
        case .tabs(.textTab(.openListTab)):
            state.selectedTab = .listTab
            return .none
        case .tabs:
            return .none
        }
    }
    
    struct Scene: View {
        let store: StoreOf<AppRoot>
        
        var body: some View {
            WithViewStore(store, observe: \.selectedTab) { viewStore in
                TabView(
                    selection: viewStore.binding(
                        send: { .updateSelectedTab($0)}
                    )
                ) {
                    tab1Scene()
                    tab2Scene()
                }
                .ignoresSafeArea()
            }
        }
        
        @ViewBuilder
        private func tab1Scene() -> some View {
            TextTab.Scene(
                store: store.scope(
                    state: \.tabsState.textTab,
                    action: { .tabs(.textTab($0)) }
                )
            )
            .tabItem {
                Label("Text Tab", systemImage: "1.circle")
            }
            .tag(AppRoot.Tabs.ID.textTab)
        }
        
        @ViewBuilder
        private func tab2Scene() -> some View {
            ListTab.Scene(
                store: store.scope(
                    state: \.tabsState.listTab,
                    action: { .tabs(.listTab($0)) }
                )
            )
            .tabItem {
                Label("List Tab", systemImage: "2.circle")
            }
            .tag(AppRoot.Tabs.ID.listTab)
        }
    }
}
