import Foundation
import SwiftUI

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
