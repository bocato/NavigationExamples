//import XCTest
//@testable import NavigationExamples
//
//final class DrillDownExample5Tests: XCTestCase {
//    func test_scene1_happyFlow() throws {
//        let sut: DrillDown.Example4.Model = .init()
//        // 1. When screen opens, no route is being presented
//        XCTAssertTrue(
//            sut.path.isEmpty,
//            "Expected initial `path` to be `empty`"
//        )
//        
//        // 2. When user taps on "Go to Scene 1" the route should change
//        let scene1ModelMock: DrillDown.Example2.Scene1Model = .init()
//        sut.navigate(to: .detail1)
//        XCTAssertEqual(
//            sut.route,
//            .scene1(scene1ModelMock),
//            "Expected `route` to be `.scene1` with correct model"
//        )
//        
//        // 3. When user taps on "Back" or swipes from left-to-right
//        sut.dismissRoute()
//        XCTAssertNil(
//            sut.route,
//            "Expected `route` to be `nil` after dismiss"
//        )
//    }
//    
////    func test_scene2_happyFlow() throws {
////        let sut: DrillDown.Example2.Model = .init()
////        // 1. When screen opens, no route is being presented
////        XCTAssertNil(
////            sut.route,
////            "Expected initial `route` to be `nil`"
////        )
////        
////        // 2. When user taps on "Go to Scene 2" the route should change
////        let scene2ModelMock: DrillDown.Example2.Scene1Model = .init(isScene2Active: true)
////        sut.dependencies.makeScene2Model = { scene2ModelMock }
////        sut.goToScene2Tapped()
////        guard
////            case let .scene2(model) = sut.route,
////            model.isScene2Active == true
////        else {
////            XCTFail("Expected `route` to be `.scene2` with correct model")
////            return
////        }
////        
////        // 3. When user taps on "Back" or swipes from left-to-right
////        sut.dismissRoute()
////        XCTAssertNil(
////            sut.route,
////            "Expected `route` to be `nil` after dismiss"
////        )
////    }
//}
