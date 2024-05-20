import SwiftUI

extension DrillDown {
    enum Example4 {}
}

extension DrillDown.Example4 {
    enum Route: Hashable {
        case detail1
        case detail2
    }
    
    final class NavigationModel: ObservableObject {
        @Published var path = NavigationPath()
        
        func navigate(to route: Route) {
            path.append(route)
        }
        
        func pop() {
            if !path.isEmpty {
                path.removeLast()
            }
        }
        
        func popToRoot() {
            path = NavigationPath()
        }
    }
    
    struct RootScene: View {
        @ObservedObject var navigationModel = NavigationModel()
        
        var body: some View {
            NavigationStack(path: $navigationModel.path) {
                VStack {
                    Button("Go to Detail View 1") {
                        navigationModel.navigate(to: .detail1)
                    }
                    .padding()
                    
                    Button("Go to Detail View 2") {
                        navigationModel.navigate(to: .detail2)
                    }
                    .padding()
                }
                .navigationTitle("Example #4")
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .detail1:
                        DetailView1(navigationModel: navigationModel)
                    case .detail2:
                        DetailView2(navigationModel: navigationModel)
                    }
                }
            }
        }
    }
    
    struct DetailView1: View {
        @ObservedObject var navigationModel: NavigationModel
        
        var body: some View {
            VStack {
                Text("Detail View 1")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Button("Go to Detail View 2") {
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
    
    struct DetailView2: View {
        @ObservedObject var navigationModel: NavigationModel
        
        var body: some View {
            VStack {
                Text("Detail View 2")
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
