import SwiftUI
import SwiftUINavigation

extension DrillDown {
    enum Example3 {}
}

// MARK: - Main Scene

extension DrillDown.Example3 {
    typealias Route = DrillDown.Example2.Route
    typealias Model = DrillDown.Example2.Model
    typealias Scene1 = DrillDown.Example2.Scene1
}

extension DrillDown.Example3 {
    struct RootScene: View {
        @ObservedObject var model: Model = .init()
        
        var body: some View {
            contentView()
                .destinationLink(
                    unwrapping: $model.route,
                    case: /Route.scene1,
                    onNavigate: { isActive in
                        if isActive { // Link will navigate
                            
                        } else { // Navigation is done... popping...
                            model.dismissRoute()
                        }
                    },
                    destination: { $scene1Model in
                        Scene1(model: scene1Model)
                    }
                )
                .destinationLink(
                    unwrapping: $model.route,
                    case: /Route.scene2,
                    onNavigate: { isActive in
                        if isActive { // Link will navigate
                            
                        } else { // Navigation is done... popping...
                            model.dismissRoute()
                        }
                    },
                    destination: { $scene2Model in
                        Scene1(model: scene2Model)
                    }
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

private extension View {
    @MainActor
    func destinationLink<Enum, Case, WrappedDestination>(
        unwrapping enum: Binding<Enum?>,
        case casePath: CasePath<Enum, Case>,
        onNavigate: ((Bool) -> Void)? = nil,
        @ViewBuilder destination: @escaping (Binding<Case>) -> WrappedDestination
    ) -> some View where WrappedDestination: View {
        overlay(
            NavigationLink(
                unwrapping: `enum`,
                case: casePath,
                onNavigate: { onNavigate?($0) },
                destination: destination,
                label: EmptyView().hidden
            )
            .isDetailLink(false)
            .opacity(.zero)
            .accessibilityHidden(true)
        )
    }
}

struct DrillDownExample3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DrillDown.Example2.RootScene()
        }
    }
}
