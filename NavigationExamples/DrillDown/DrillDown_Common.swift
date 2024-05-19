import SwiftUI

enum DrillDown {}

extension DrillDown {
    struct Scene2: View {
        var body: some View {
            VStack {
                Spacer()
                Text("2️⃣")
                    .font(.largeTitle)
                Spacer()
            }
            .navigationTitle("Scene 2")
        }
    }
}

extension DrillDown {
    static func example1() -> some View {
        NavigationView {
            Example2.RootScene()
                .navigationTitle("Example #1")
        }
    }
    
    static func example2() -> some View {
        NavigationView {
            Example2.RootScene()
                .navigationTitle("Example #2")
        }
    }
    
    static func example3() -> some View {
        NavigationView {
            Example3.RootScene()
                .navigationTitle("Example #3")
        }
    }
}
