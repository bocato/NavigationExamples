import SwiftUI

extension Modal {
    enum Example1 {}
}
extension Modal.Example1 {
    // MARK: - Main Scene
    
    struct Scene: View {
        @State var isPresentingScreenA: Bool = false
        @State var isPresentingScreenB: Bool = false
        
        var body: some View {
            contentView()
                .sheet(
                    isPresented: $isPresentingScreenA,
                    onDismiss: {
                        isPresentingScreenA = false
                    },
                    content: {
                        NavigationView {
                            Modal.ScreenA(
                                model: .init(),
                                onDismiss: {
                                    isPresentingScreenA = false
                                }
                            )
                        }
                    }
                )
                .sheet(
                    isPresented: $isPresentingScreenB,
                    onDismiss: {
                        isPresentingScreenB = false
                    },
                    content: {
                        NavigationView {
                            Modal.ScreenB(
                                onDismiss: {
                                    isPresentingScreenB = false
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
                    isPresentingScreenA = true
                }
                Button("Open Screen B") {
                    isPresentingScreenB = true
                }
                Spacer()
            }
            .buttonStyle(.bordered)
        }
    }
}

struct ModalExample1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Modal.Example1.Scene()
        }
    }
}
