import XCTest
@testable import SwiftConferencesAPIKit

final class SwiftConferencesAPIKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftConferencesAPIKit.text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
