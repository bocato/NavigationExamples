import SwiftUI


// MARK: - Internal Scene 1
extension DrillDown.Example2 {
    final class Scene1Model: ObservableObject, Equatable {
        @Published var isScene2Active: Bool
        
        init(isScene2Active: Bool = false) {
            self.isScene2Active = isScene2Active
        }
        
        static func == (lhs: Scene1Model, rhs: Scene1Model) -> Bool {
            lhs === rhs
        }
    }
    
    struct Scene1: View {
        @ObservedObject var model: Scene1Model
        
        var body: some View {
            VStack {
                Spacer()
                Text("1️⃣")
                    .font(.largeTitle)
                List {
                    NavigationLink(isActive: $model.isScene2Active) {
                        DrillDown.Scene2()
                    } label: {
                        Text("Go to Scene 2")
                    }
                }
            }
            .navigationTitle("Scene 1")
        }
    }
}
