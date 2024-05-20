import SwiftUI

extension Container {
    enum Example1 {}
}

extension Container.Example1 {
    struct Scene: View {
        typealias Tab = Container.Tab
        
        var body: some View {
            TabView {
                Container.textTabOne()
                Container.textTabTwo()
                Container.textTabThree()
            }
        }
    }
}

struct ContainerExample1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Container.Example1.Scene()
        }
    }
}
