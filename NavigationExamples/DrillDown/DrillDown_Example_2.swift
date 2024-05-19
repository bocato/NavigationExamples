import SwiftUI

extension DrillDown {
    enum Example2 {}
}

// MARK: - Main Scene

extension DrillDown.Example2 {
    enum Route: Identifiable, Equatable {
        var id: String { String(describing: self) }
        case scene1(Scene1Model)
        case scene2(Scene1Model)
    }
}

extension DrillDown.Example2 {
    final class Model: ObservableObject {
        @Published var route: Route?
        
        struct Dependencies {
            var makeScene1Model: () -> Scene1Model = { Scene1Model() }
            var makeScene2Model: () -> Scene1Model = { Scene1Model(isScene2Active: true) }
        }
        var dependencies: Dependencies
        
        init(dependencies: Dependencies = .init()) {
            self.dependencies = dependencies
        }

        func goToScene1Tapped() {
            let model = dependencies.makeScene1Model()
            route = .scene1(model)
        }

        func goToScene2Tapped() {
            let model = dependencies.makeScene2Model()
            route = .scene2(model)
        }
        
        func dismissRoute() {
            route = nil
        }
    }
    
    struct RootScene: View {
        @ObservedObject var model: Model = .init()
        
        var body: some View {
            contentView()
                .overlay(
                    NavigationLink(
                        isActive: .init(
                            get: { model.route != nil },
                            set: { isActive in
                                if !isActive { // will dismiss (swipe or back)
                                    model.dismissRoute()
                                }
                            }
                        ),
                        destination: {
                            if let route = model.route {
                                switch route {
                                case let .scene1(scene1Model):
                                    Scene1(model: scene1Model)
                                case let .scene2(scene2Model):
                                    Scene1(model: scene2Model)
                                }
                            }
                        },
                        label: EmptyView().hidden
                    )
                    .isDetailLink(false)
                    .opacity(.zero)
                    .accessibilityHidden(true)
                )
        }
        
        @ViewBuilder
        private func contentView() -> some View {
            List {
                Button("Go to Scene 1") {
                    model.goToScene1Tapped()
                }
                Button("Go to Scene 2") {
                    model.goToScene2Tapped()
                }
            }
        }
    }
}

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

struct DrillDownExample2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrillDown.Example2.RootScene()
        }
    }
}
