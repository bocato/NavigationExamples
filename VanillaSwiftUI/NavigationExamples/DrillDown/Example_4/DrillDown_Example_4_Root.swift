import SwiftUI

extension DrillDown {
    enum Example4 {}
}

extension DrillDown.Example4 {
    typealias Model = DrillDown.Example4.NavigationModel
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
            guard !path.isEmpty else { return }
            path.removeLast()
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
                    Button("Go to Scene 1") {
                        navigationModel.navigate(to: .detail1)
                    }
                    .padding()
                    
                    Button("Go to Scene 2") {
                        navigationModel.navigate(to: .detail2)
                    }
                    .padding()
                }
                .navigationTitle("Example #4")
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .detail1:
                        Scene1(navigationModel: navigationModel)
                    case .detail2:
                        Scene2(navigationModel: navigationModel)
                    }
                }
            }
        }
    }
}
