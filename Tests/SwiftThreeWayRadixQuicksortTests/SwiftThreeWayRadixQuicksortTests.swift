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
    
    func testMobyDick() {
        var path = "./Tests/Resources/mobydick.txt"
        if let bundlePath = Bundle(for: Swift.type(of: self)).path(forResource: "mobydick.txt", ofType: "txt") {
            path = bundlePath
        }
        var mobyWords = try! String(contentsOfFile: path).components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        var copy = mobyWords
        
        copy.sort()
        
        measure {
            mobyWords.sortRadixQuicksort()
        }
        
        XCTAssertEqual(copy, mobyWords)
    }
    
    func testMobyDickStandardComparison() {
        var path = "./Tests/Resources/mobydick.txt"
        if let bundlePath = Bundle(for: Swift.type(of: self)).path(forResource: "mobydick.txt", ofType: "txt") {
            path = bundlePath
        }
        var mobyWords = try! String(contentsOfFile: path).components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        
        measure {
            mobyWords.sort()
        }
        
    }

    static var allTests = [
        ("testBasic", testBasic),
        ("testMobyDick", testMobyDick),
        ("testMobyDickStandardComparison", testMobyDickStandardComparison),
    ]
}
