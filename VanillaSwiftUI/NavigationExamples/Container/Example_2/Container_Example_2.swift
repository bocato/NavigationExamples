import SwiftUI

extension Container {
    enum Example2 {}
}

extension Container.Example2 {
    typealias Tab = Container.Tab
    
    final class Model: ObservableObject {
        @Published var currentTab: Tab = .one
        
        func goToTabThreeTapped() {
            currentTab = .three
        }
    }
    
    struct Scene: View {
        @ObservedObject var model: Model = .init()
        
        var body: some View {
            TabView(selection: $model.currentTab) {
                VStack {
                    Spacer()
                    Text("1️⃣")
                        .font(.largeTitle)
                        .tabItem {
                            Label(
                                Tab.one.itemTitle,
                                systemImage: Tab.one.itemImage
                            )
                        }
                    Spacer()
                    Button("Go to Tab 3") {
                        model.goToTabThreeTapped()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .tabItem {
                    Label(
                        Tab.one.itemTitle,
                        systemImage: Tab.one.itemImage
                    )
                }
                .tag(Tab.one)
                
                Container.textTabTwo()
                    .tag(Tab.two)
                
                Container.textTabThree()
                    .tag(Tab.three)
            }
        }
    }
}

struct ContainerExample2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Container.Example2.Scene()
        }
    }
}
