import SwiftUI
import Combine
import SwiftUINavigation

extension Modal {
    enum Example3 {}
}

extension Modal.Example3 {
    typealias Route = Modal.Example2.Route
    typealias Model = Modal.Example2.Model
}

extension Modal.Example3 {
    struct Scene: View {
        @ObservedObject var model: Model = .init()
        
        var body: some View {
            contentView()
                .sheet(
                    unwrapping: $model.route,
                    case: /Route.screenA,
                    onDismiss: {
                        model.dismissModal()
                    },
                    content: { $screenAModel in
                        NavigationView {
                            Modal.ScreenA(
                                model: screenAModel,
                                onDismiss: {
                                    model.dismissModal()
                                }
                            )
                        }
                    }
                )
                .sheet(
                    unwrapping: $model.route,
                    case: /Route.screenB,
                    onDismiss: {
                        model.dismissModal()
                    },
                    content: { _ in
                        NavigationView {
                            Modal.ScreenB(
                                onDismiss: {
                                    model.dismissModal()
                                }
                            )
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

struct ModalExample3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Modal.Example3.Scene()
        }
    }
}
