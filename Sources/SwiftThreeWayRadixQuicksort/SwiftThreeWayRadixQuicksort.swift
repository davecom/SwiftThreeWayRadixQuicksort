//   SwiftThreeWayRadixQuicksort.swift
//   Based on Algorithms 4th Edition by Sedgewick and Wayne pg 719
//   and online at https://algs4.cs.princeton.edu/51radix/Quick3string.java.html
//
//   Copyright 2019 David Kopec
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

extension String {
    @inline(__always) func character(at: Int) -> Character? {
        if at >= count || at < 0 { return nil }
        return self[index(startIndex, offsetBy: at)]
    }
}

extension Array where Element == String {
    
    static let SORT_CUTOFF: Int = 5
    
    func less(first: String, second: String, characterIndex: Int) -> Bool {
        for i in characterIndex..<Swift.min(first.count, second.count) {
            if let fc = first.character(at: i) {
                if let sc = second.character(at: i) {
                    if fc < sc { return true }
                    else if fc > sc { return false }
                }
            }
        }
        return first.count < second.count
    }
    
    mutating func insertionSort(low: Int, high: Int, characterIndex: Int) {
        if low > high { return }
        for i in low...high {
            if (low+1) > i { continue }
            for j in ((low+1)...i).reversed() {
                if !less(first: self[j], second: self[j - 1], characterIndex: characterIndex) { break }
                swapAt(j, j-1)
            }
        }
    }
    
    mutating func sortHelper(low: Int, high: Int, characterIndex: Int) {
        //if high <= low { return }
        if high <= (low + Array<Element>.SORT_CUTOFF) {
            insertionSort(low: low, high: high, characterIndex: characterIndex)
            return
        }
        
        var lessThan = low
        var greaterThan = high
        let pivotCharacter = self[low].character(at: characterIndex)
        var i = low + 1
        while i <= greaterThan {
            let currentCharacter = self[i].character(at: characterIndex)
            switch (currentCharacter, pivotCharacter) {
            case (nil, .some):
                swapAt(lessThan, i)
                lessThan += 1
                i += 1
            case let (cc?, pc?) where cc < pc:
                swapAt(lessThan, i)
                lessThan += 1
                i += 1
            case (.some, nil):
                swapAt(i, greaterThan)
                greaterThan -= 1
            case let (cc?, pc?) where cc > pc:
                swapAt(i, greaterThan)
                greaterThan -= 1
            default:
                i += 1
            }
        }
        sortHelper(low: low, high: lessThan-1, characterIndex: characterIndex)
        if pivotCharacter != nil { sortHelper(low: lessThan, high: greaterThan, characterIndex: characterIndex+1) }
        sortHelper(low: greaterThan+1, high: high, characterIndex: characterIndex)
    }
    
    mutating public func sortRadixQuicksort() {
        sortHelper(low: 0, high: count - 1, characterIndex: 0)
    }
}
