import SwiftUI

extension DrillDown.Example5 {
    final class Scene1Model: ObservableObject, Identifiable, Hashable {
        var onGotScene2Tapped: () -> Void = { fatalError("unimplemented") }
        var onGoBackTapped: () -> Void = { fatalError("unimplemented") }
        
        init() {}
        
        func goToScene2() {
            onGotScene2Tapped()
        }
        
        func goBack() {
            onGoBackTapped()
        }
        
        // MARK: - Identifiable, Hashable
        
        var identifier: String {
            return UUID().uuidString
        }
        
        public func hash(into hasher: inout Hasher) {
            return hasher.combine(identifier)
        }
        
        public static func == (lhs: Scene1Model, rhs: Scene1Model) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    
    struct Scene1: View {
        @ObservedObject var model: Scene1Model
        
        var body: some View {
            VStack {
                Text("Scene 1")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Button("Go to Scene 2") {
                    model.goToScene2()
                }
                .padding()
                Button("Go Back") {
                    model.goBack()
                }
                .padding()
                Spacer()
            }
        }
    }
}
