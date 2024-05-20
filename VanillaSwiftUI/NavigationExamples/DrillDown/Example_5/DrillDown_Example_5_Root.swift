import SwiftUI

extension DrillDown {
    enum Example5 {}
}

extension DrillDown.Example5 {
    struct SceneModelBuilder {
        var buildScene1Model: () -> Scene1Model = Scene1Model.init
        var buildScene2Model: () -> Scene2Model = Scene2Model.init
    }
    
    enum Path: Hashable {
        case scene1(Scene1Model)
        case scene2(Scene2Model)
    }
    
    final class RootModel: ObservableObject {
        var sceneModelBuilder = SceneModelBuilder()
        @Published var path: [Path] = []
        
        func navigateToScene1() {
            let model = sceneModelBuilder.buildScene1Model()
            model.onGoBackTapped = { [weak self] in
                self?.popPath()
            }
            model.onGotScene2Tapped = { [weak self] in
                self?.navigateToScene2()
            }
            
            path.append(
                .scene1(model)
            )
        }
        
        func navigateToScene2() {
            let model = sceneModelBuilder.buildScene2Model()
            model.onGoBackToRootTapped = { [weak self] in
                self?.popToRoot()
            }
            path.append(
                .scene2(model)
            )
        }
        
        func popPath() {
            guard !path.isEmpty else { return }
            path.removeLast()
        }
        
        func popToRoot() {
            path = []
        }
    }
    
    struct RootScene: View {
        @ObservedObject var model = RootModel()
        
        var body: some View {
            NavigationStack(path: $model.path) {
                VStack {
                    Button("Go to Scene 1") {
                        model.navigateToScene1()
                    }
                    .padding()
                    
                    Button("Go to Scene 2") {
                        model.navigateToScene2()
                    }
                    .padding()
                }
                .navigationTitle("Example #4")
                .navigationDestination(for: Path.self) { route in
                    switch route {
                    case let .scene1(model):
                        Scene1(model: model)
                    case let .scene2(model):
                        Scene2(model: model)
                    }
                }
            }
        }
    }
}
