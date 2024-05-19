import SwiftUI
import Combine

extension Modal {
    enum Example2 {}
}

// MARK: - Main Scene

extension Modal.Example2 {
    enum Route: Identifiable, Equatable {
        var id: String { String(describing: self) }
        
        case screenA(Modal.ScreenAModel)
        case screenB
    }
}

extension Modal.Example2 {
    final class Model: ObservableObject {
        @Published var route: Route?
        @Published var screenAModel: Modal.ScreenAModel?
        
        struct Dependencies {
            var makeScreenAModel: () -> Modal.ScreenAModel = Modal.ScreenAModel.init
        }
        var dependencies: Dependencies
        
        init(dependencies: Dependencies = .init()) {
            self.dependencies = dependencies
        }
        
        func openScreenATapped() {
            let model: Modal.ScreenAModel
            if let screenAModel {
                model = screenAModel
            } else {
                model = dependencies.makeScreenAModel()
                screenAModel = model
            }
            route = .screenA(model)
        }
        
        func openScreenBTapped() {
            route = .screenB
        }
        
        func dismissModal() {
            if screenAModel != nil {
                screenAModel = nil
            }
            route = nil
        }
    }
}

extension Modal.Example2 {
    struct Scene: View {
        @ObservedObject var model: Model = .init()
        
        var body: some View {
            contentView()
                .sheet(
                    item: $model.route,
                    onDismiss: {
                        model.dismissModal()
                    },
                    content: { route in
                        switch route {
                        case let .screenA(screenAModel):
                            NavigationView {
                                Modal.ScreenA(
                                    model: screenAModel,
                                    onDismiss: {
                                        model.dismissModal()
                                    }
                                )
                            }
                        case .screenB:
                            NavigationView {
                                Modal.ScreenB(
                                    onDismiss: {
                                        model.dismissModal()
                                    }
                                )
                            }
                        }
                    }
                )
        }
        
        @ViewBuilder
        private func contentView() -> some View {
            VStack {
                Spacer()
                Button("Open Screen A") {
                    model.openScreenATapped()
                }
                Button("Open Screen B") {
                    model.openScreenBTapped()
                }
                Spacer()
            }
            .buttonStyle(.bordered)
        }
    }
}

struct ModalExample2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Modal.Example2.Scene()
        }
    }
}
