import SwiftUI

extension DrillDown.Example4 {
 struct Scene1: View {
        @ObservedObject var navigationModel: NavigationModel
        
        var body: some View {
            VStack {
                Text("Scene 1")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Button("Go to Scene 2") {
                    navigationModel.navigate(to: .detail2)
                }
                .padding()
                Button("Go Back") {
                    navigationModel.pop()
                }
                .padding()
                Spacer()
            }
        }
    }
    
    struct Scene2: View {
        @ObservedObject var navigationModel: NavigationModel
        
        var body: some View {
            VStack {
                Text("Scene 2")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Button("Go Back to Root") {
                    navigationModel.popToRoot()
                }
                .padding()
                Spacer()
            }
        }
    }
}
