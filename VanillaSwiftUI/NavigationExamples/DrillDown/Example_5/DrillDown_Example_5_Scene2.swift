import SwiftUI

extension DrillDown.Example5 {
    final class Scene2Model: ObservableObject, Identifiable, Hashable {
        var onGoBackToRootTapped: () -> Void = { fatalError("unimplemented") }
        
        init() {}
        
        func goBackToRoot() {
            onGoBackToRootTapped()
        }
        
        // Identifiable, Hashable
        var identifier: String {
            return UUID().uuidString
        }
        
        public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
        }
        
        public static func == (lhs: Scene2Model, rhs: Scene2Model) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    
    struct Scene2: View {
        @ObservedObject var model: Scene2Model
        
        var body: some View {
            VStack {
                Text("Scene 2")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Button("Go Back to Root") {
                    model.goBackToRoot()
                }
                .padding()
                Spacer()
            }
        }
    }
}
