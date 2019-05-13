import XCTest
@testable import SwiftThreeWayRadixQuicksort

final class SwiftThreeWayRadixQuicksortTests: XCTestCase {
    func testBasic() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        var original: [String] = ["she", "sells", "seashells", "by", "the", "sea", "shore",
                                 "the", "shells", "she", "sells", "are", "surely", "seashells"]
        let copy = original.sorted()
        original.sortRadixQuicksort()
        XCTAssertEqual(original, copy)
    }

    static var allTests = [
        ("testBasic", testBasic),
    ]
}
