import SwiftUI

extension DrillDown {
    enum Example5 {}
}

extension DrillDown.Example5 {
    struct SceneModelBuilder {
        var buildScene1Model: () -> Scene1Model = Scene1Model.init
        var buildScene2Model: () -> Scene2Model = Scene2Model.init
    }
    
    enum Route: Hashable {
        case scene1(Scene1Model)
        case scene2(Scene2Model)
    }
    
    final class RootModel: ObservableObject {
        var sceneModelBuilder = SceneModelBuilder()
        @Published var path = NavigationPath()
        
        func navigateToScene1() {
            let model = sceneModelBuilder.buildScene1Model()
            model.onGoBackTapped = { [weak self] in
                self?.popPath()
            }
            model.onGotScene2Tapped = { [weak self] in
                self?.navigateToScene2()
            }
            
            path.append(
                Route.scene1(model)
            )
        }
        
        func navigateToScene2() {
            let model = sceneModelBuilder.buildScene2Model()
            model.onGoBackToRootTapped = { [weak self] in
                self?.popToRoot()
            }
            path.append(
                Route.scene2(model)
            )
        }
        
        func popPath() {
            guard !path.isEmpty else { return }
            path.removeLast()
        }
        
        func popToRoot() {
            path = NavigationPath()
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
                .navigationDestination(for: Route.self) { route in
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
