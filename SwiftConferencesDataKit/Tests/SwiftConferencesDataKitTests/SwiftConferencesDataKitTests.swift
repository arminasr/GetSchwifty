import XCTest
@testable import SwiftConferencesDataKit

final class SwiftConferencesDataKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftConferencesDataKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
