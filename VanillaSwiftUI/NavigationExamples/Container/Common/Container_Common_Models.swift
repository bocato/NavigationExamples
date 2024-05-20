import Foundation
import SwiftUI

enum Container {}

extension Container {
    enum Tab: Equatable, Hashable {
        case one, two, three
    }
}

extension Container.Tab {
    var itemTitle: String {
        switch self {
        case .one:
            return "Tab 3"
        case .two:
            return "Tab 3"
        case .three:
            return "Tab 3"
        }
    }
    
    var itemImage: String {
        switch self {
        case .one:
            return "1.lane"
        case .two:
            return "2.lane"
        case .three:
            return "3.lane"
        }
    }
}
