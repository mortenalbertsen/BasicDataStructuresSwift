import XCTest
@testable import Basic

final class BasicTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Basic().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
