import Foundation
import SwiftUI

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
