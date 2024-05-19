import Foundation
import UIKit
import SwiftUI

enum Modal {}
extension Modal {
    final class ScreenAModel: ObservableObject, Equatable {
        @Published var backgroundColor: UIColor = .red
        
        func toggleBackgroundTapped() {
            if backgroundColor == .red {
                backgroundColor = .green
            } else {
                backgroundColor = .red
            }
        }
        
        static func == (lhs: ScreenAModel, rhs: ScreenAModel) -> Bool {
            lhs === rhs
        }
    }
}

extension Modal {
    struct ScreenA: View {
        @ObservedObject var model: ScreenAModel
        let onDismiss: () -> Void
        
        var body: some View {
            VStack {
                Spacer()
                Text("Screen A")
                Button("Toggle background") {
                    model.toggleBackgroundTapped()
                }
                Spacer()
            }
            .background(Color(uiColor: model.backgroundColor))
            .toolbar {
                ToolbarItem(
                    placement: .navigationBarTrailing,
                    content: {
                        Button("Close", action: onDismiss)
                    }
                )
            }
        }
    }
}

extension Modal {
    struct ScreenB: View {
        let onDismiss: () -> Void
        
        var body: some View {
            VStack {
                Spacer()
                Text("Screen B")
                Spacer()
            }.toolbar {
                ToolbarItem(
                    placement: .navigationBarTrailing,
                    content: {
                        Button("Close", action: onDismiss)
                    }
                )
            }
        }
    }
}

extension Modal {
    static func example1() -> some View {
        NavigationView {
            Example2.Scene()
                .navigationTitle("Example #1")
        }
    }
    
    static func example2() -> some View {
        NavigationView {
            Example2.Scene()
                .navigationTitle("Example #2")
        }
    }
    
    static func example3() -> some View {
        NavigationView {
            Example3.Scene()
                .navigationTitle("Example #3")
        }
    }
}
