import Foundation
import SwiftUI

enum Container {}

extension Container {
    enum Tab: Equatable, Hashable {
        case one, two, three
    }
}

extension Container.Tab {
    var itemTitle: String {
        switch self {
        case .one:
            return "Tab 3"
        case .two:
            return "Tab 3"
        case .three:
            return "Tab 3"
        }
    }
    
    var itemImage: String {
        switch self {
        case .one:
            return "1.lane"
        case .two:
            return "2.lane"
        case .three:
            return "3.lane"
        }
    }
}

extension Container {
    @ViewBuilder
    static func textTabOne() -> some View {
        Text("1️⃣")
            .font(.largeTitle)
            .tabItem {
                Label(
                    Tab.one.itemTitle,
                    systemImage: Tab.one.itemImage
                )
            }
    }
    
    @ViewBuilder
    static func textTabTwo() -> some View {
        Text("2️⃣")
            .font(.largeTitle)
            .tabItem {
                Label(
                    Tab.two.itemTitle,
                    systemImage: Tab.two.itemImage
                )
            }
    }
    
    @ViewBuilder
    static func textTabThree() -> some View {
        Text("3️⃣")
            .font(.largeTitle)
            .tabItem {
                Label(
                    Tab.one.itemTitle,
                    systemImage: Tab.two.itemImage
                )
            }
    }
}

extension Container {
    static func example1() -> some View {
        NavigationView {
            Example1.Scene()
                .navigationTitle("Example #1")
        }
    }
    
    static func example2() -> some View {
        NavigationView {
            Example2.Scene()
                .navigationTitle("Example #2")
        }
    }
}
