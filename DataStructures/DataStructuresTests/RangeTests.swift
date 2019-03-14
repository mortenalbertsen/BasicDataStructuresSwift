//
//  RangeTree.swift
//  DataStructuresTests
//
//  Created by Morten on 11/03/2019.
//  Copyright © 2019 Morten Albertsen. All rights reserved.
//

import XCTest
@testable import DataStructures

class RangeTests: XCTestCase {
    
    let ranges = [1..<3, 12..<15, 24..<27]
    let arrayOfTwoRanges = [40..<42, 70..<80]

    func testEmptyDoesNotContain1_2() {
        let tree = RangeImplementation()
        let result = tree.contains(integer: 1)
        XCTAssert(result == false)
    }
    
    func testContainsLowerBoundInRangeAfterInsertion() {
        let rangeBeingInserted = Range<Int>(uncheckedBounds: (lower: 1, upper: 2))
        let tree = RangeImplementation()
        tree.insert(range: rangeBeingInserted)
        let containsResult = tree.contains(integer: 1)
        XCTAssert(containsResult == true)
    }
    
    func testDoesNotContainUpperBoundInRangeAfterInsertion() {
        let rangeBeingInserted = Range<Int>(uncheckedBounds: (lower: 1, upper: 2))
        let tree = RangeImplementation()
        tree.insert(range: rangeBeingInserted)
        let containsResult = tree.contains(integer: 2)
        XCTAssert(containsResult == false)
    }
    
    func testInsertMultipleNotOverlappingRanges() {
        let tree = RangeImplementation()
        tree.insert(range: 1..<3)
        tree.insert(range: 10..<13)
        XCTAssert(tree.contains(integer: 1))
        XCTAssert(tree.contains(integer: 11))
        XCTAssert(!tree.contains(integer: 3))
        XCTAssert(!tree.contains(integer: 13))
        XCTAssert(!tree.contains(integer: -10))
        XCTAssert(!tree.contains(integer: 20))
    }
    
    func testInsertOverlappingRanges() {
        let tree = RangeImplementation()
        tree.insert(range: 1..<3)
        tree.insert(range: -2..<8)
        XCTAssert(tree.contains(integer: 1))
        XCTAssert(tree.contains(integer: 7))
        XCTAssert(!tree.contains(integer: 8))
        XCTAssert(!tree.contains(integer: -3))
    }
    
    
    // MARK: Array of 3 ranges
    func testFindIndex_1() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 1, inRanges: self.ranges)
        let expectedIndex = 0
        XCTAssert(returnedIndex == expectedIndex)
    }
    
    func testFindIndex_2() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 2, inRanges: self.ranges)
        let expectedIndex = 0
        XCTAssertEqual(returnedIndex, expectedIndex)
    }

    func testFindIndex_3() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 12, inRanges: self.ranges)
        let expectedIndex = 1
        XCTAssert(returnedIndex == expectedIndex)
    }
    
    func testFindIndex_4() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 13, inRanges: self.ranges)
        let expectedIndex = 1
        XCTAssert(returnedIndex == expectedIndex)
    }
    
    func testFindIndex_5() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 24, inRanges: self.ranges)
        let expectedIndex = 2
        XCTAssert(returnedIndex == expectedIndex)
    }
    
    func testFindIndex_6() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 25, inRanges: self.ranges)
        let expectedIndex = 2
        XCTAssert(returnedIndex == expectedIndex)
    }
    
    func testFindIndex_7() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 30, inRanges: self.ranges)
        let expectedIndex = 2
        XCTAssert(returnedIndex == expectedIndex)
    }
    
    func testFindIndex_8() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: -8, inRanges: self.ranges)
        XCTAssertNil(returnedIndex)
    }
    
    func testFindIndex_9() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 4, inRanges: self.ranges)
        let expectedIndex = 0
        XCTAssert(returnedIndex == expectedIndex)
    }
    
    // MARK: Array of two ranges
    func testFindIndex_10() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 4, inRanges: self.arrayOfTwoRanges)
        XCTAssertNil(returnedIndex)
    }
    
    func testFindIndex_11() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 39, inRanges: self.arrayOfTwoRanges)
        XCTAssertNil(returnedIndex)
    }
    
    func testFindIndex_12() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 40, inRanges: self.arrayOfTwoRanges)
        
        XCTAssertEqual(returnedIndex, 0)
    }
    
    func testFindIndex_13() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 41, inRanges: self.arrayOfTwoRanges)
        
        XCTAssertEqual(returnedIndex, 0)
    }
    
    func testFindIndex_14() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 69, inRanges: self.arrayOfTwoRanges)
        
        XCTAssertEqual(returnedIndex, 0)
    }
    
    func testFindIndex_15() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 70, inRanges: self.arrayOfTwoRanges)
        
        XCTAssertEqual(returnedIndex, 1)
    }
    
    func testFindIndex_16() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 100, inRanges: self.arrayOfTwoRanges)
        
        XCTAssertEqual(returnedIndex, 1)
    }
    
    // MARK: Empty array
    func testFindIndex_17() {
        let returnedIndex = RangeImplementation.findIndex(forLowerBound: 100, inRanges: [])
        
        XCTAssertNil(returnedIndex)
    }
}
