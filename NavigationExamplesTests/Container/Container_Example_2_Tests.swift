import XCTest
@testable import NavigationExamples

final class ContainerExample2Tests: XCTestCase {
    func test_container_changeTab() throws {
        let sut: Container.Example2.Model = .init()
        // 1. When screen opens, initial tab should be `.one`
        XCTAssertEqual(
            sut.currentTab,
            .one,
            "Expected initial tab to be `.one`"
        )
        
        // 2. When user taps on "Go to Tab 3" the tab should change
        sut.goToTabThreeTapped()
        XCTAssertEqual(
            sut.currentTab,
            .three,
            "Expected `currentTab` to be `.three`"
        )
    }
}
