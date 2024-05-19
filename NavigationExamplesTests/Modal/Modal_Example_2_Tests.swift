import XCTest
@testable import NavigationExamples

final class ModalExample2Tests: XCTestCase {
    func test_screenA_happyFlow() throws {
        let sut: Modal.Example2.Model = .init()
        // 1. When screen opens, no route is being presented
        XCTAssertNil(
            sut.route,
            "Expected initial `route` to be `nil`"
        )
        
        // 2. When user taps on "Open Screen A" the route should change
        let screenAModelMock: Modal.ScreenAModel = .init()
        sut.dependencies.makeScreenAModel = { screenAModelMock }
        sut.openScreenATapped()
        XCTAssertEqual(
            sut.route,
            .screenA(screenAModelMock),
            "Expected `route` to be `.screenA` with correct model"
        )
        
        // 3. When toggles background on `ScreenA` it should change to Green
        screenAModelMock.toggleBackgroundTapped()
        XCTAssertEqual(
            sut.screenAModel?.backgroundColor,
            .green,
            "Expected `background` to be `.green`"
        )
        
        // 4. When user taps on "X or Close" or swipes down
        sut.dismissModal()
        XCTAssertNil(
            sut.route,
            "Expected `route` to be `nil` after dismiss"
        )
    }
    
    func test_screenB_happyFlow() throws {
        let sut: Modal.Example2.Model = .init()
        // 1. When screen opens, no route is being presented
        XCTAssertNil(
            sut.route,
            "Expected initial `route` to be `nil`"
        )
        
        // 2. When user taps on "Open Screen A" the route should change
        sut.openScreenBTapped()
        XCTAssertEqual(
            sut.route,
            .screenB,
            "Expected `route` to be `.screenB`"
        )
        
        // 3. When user taps on "X or Close" or swipes down
        sut.dismissModal()
        XCTAssertNil(
            sut.route,
            "Expected `route` to be `nil` after dismiss"
        )
    }
}
