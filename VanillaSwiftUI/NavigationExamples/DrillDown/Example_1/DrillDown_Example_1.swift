import SwiftUI

extension DrillDown {
    enum Example1 {}
}

extension DrillDown.Example1 {
    struct RootScene: View {
        var body: some View {
            contentView()
        }
        
        @ViewBuilder
        private func contentView() -> some View {
            List {
                NavigationLink {
                   Scene1()
                } label: {
                    Text("Go to Scene 1")
                }
                NavigationLink {
                    Scene1(isScene2Active: true)
                } label: {
                    Text("Go to Scene 2")
                }
            }
        }
    }
}

extension DrillDown.Example1 {
    struct Scene1: View {
        @State var isScene2Active: Bool = false
        var body: some View {
            VStack {
                Spacer()
                Text("1️⃣")
                    .font(.largeTitle)
                List {
                    NavigationLink(isActive: $isScene2Active) {
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

struct DrillDownExample1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrillDown.Example1.RootScene()
        }
    }
}
