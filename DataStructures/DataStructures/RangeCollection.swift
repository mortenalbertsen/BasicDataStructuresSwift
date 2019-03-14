//
//  RangeCollection.swift
//  DataStructures
//
//  Created by Morten on 13/03/2019.
//  Copyright © 2019 Morten Albertsen. All rights reserved.
//

import Foundation

protocol RangeContainer {
    func insert(range: Range<Int>) -> Void
    func contains(integer: Int) -> Bool
}

class RangeImplementation : RangeContainer {
    
    var ranges = [Range<Int>]()
    
    func insert(range rangeToInsert: Range<Int>) {
        if ranges.isEmpty {
            // Easy - insert immediately
            ranges.append(rangeToInsert)
            return
        }
        
        // Do binary search of where to insert
        let insertionIndex = RangeImplementation.findIndex(forLowerBound: rangeToInsert.lowerBound, inRanges: self.ranges) ?? 0
        if !ranges[insertionIndex].overlaps(rangeToInsert) {
            ranges.insert(rangeToInsert, at: insertionIndex + 1)
            return
        }
        
        let mergeIndexStart = insertionIndex
        var lastIndexContainingRange = mergeIndexStart
        while lastIndexContainingRange + 1 < ranges.count && ranges[lastIndexContainingRange + 1].overlaps(rangeToInsert) {
            lastIndexContainingRange = lastIndexContainingRange + 1
        }

        let lastOverlappingRange = ranges[lastIndexContainingRange]
        let newLowerBoundForInsertedRange = min(lastOverlappingRange.lowerBound, rangeToInsert.lowerBound)
        let newUpperBoundForInsertedRange = max(lastOverlappingRange.upperBound, rangeToInsert.upperBound)
        
        // Remove to-be overlapped ranges from array
        ranges.removeSubrange(mergeIndexStart...lastIndexContainingRange)
        
        // Insert new range
        let mergedRange = newLowerBoundForInsertedRange..<newUpperBoundForInsertedRange
        ranges.insert(mergedRange, at: insertionIndex)
    }
    
    /**
     Returns the last index that could potentially overlap with the range given.
     Detailed explanation: Let "A" be the highest index containing a range whose lowerbound is lower than the given range's lowerbound. A is returned.
     Callers will themselves have to verify whether there is an actual overlap (or not) on (the range on) the returned index.
     
    */
    func findIndexOfInsertion(forLowerBound lowerBound: Int) -> Int {
        if ranges.isEmpty {
            return 0
        }

        var topIndex = ranges.endIndex - 1
        var bottomIndex = 0
        var probingIndex = Int(topIndex / 2)
        
        while bottomIndex != topIndex {
            let rangeAtProbingIndex = ranges[probingIndex]
            if rangeAtProbingIndex.lowerBound < lowerBound {
                bottomIndex = probingIndex
            } else if rangeAtProbingIndex.lowerBound > lowerBound {
                topIndex = probingIndex
            } else {
                return probingIndex
            }
            probingIndex = bottomIndex + Int( (topIndex - bottomIndex)/2 )
        }
        
        return probingIndex
    }
    
    func contains(integer: Int) -> Bool {
        if ranges.isEmpty {
            return false
        }
        
        // Find the highest index that contains a range whose lowerbound is lower than or equal to the searched for integer
        if let relevantIndexToTest = RangeImplementation.findIndex(forLowerBound: integer, inRanges: self.ranges) {
            return ranges[relevantIndexToTest].contains(integer)
        }
        return false
    }
    
    
    static func findIndex(forLowerBound lowerBound: Int, inRanges ranges: [Range<Int>]) -> Int? {
        
        if ranges.isEmpty {
            return nil
        } else if ranges[0].lowerBound > lowerBound {
            return nil
        } else if ranges.last!.lowerBound <= lowerBound {
            return ranges.endIndex - 1
        }
        
        
        // Find the highest index that contains a range whose lowerbound is lower than or equal to the searched for integer
        var bottomIndex = 0
        var topIndex = ranges.endIndex - 1
        var sampleIndex = Int(topIndex / 2)
        
        while bottomIndex != topIndex {
            let sampledRange = ranges[sampleIndex]
            let sampleLowerBound = sampledRange.lowerBound
            if lowerBound == sampleLowerBound {
                return sampleIndex
            } else if lowerBound > sampleLowerBound {
                if lowerBound < ranges[sampleIndex + 1].lowerBound {
                    // We're at the threshold
                    return sampleIndex
                }
                
                // Move sampling to the right
                bottomIndex = sampleIndex
                sampleIndex = bottomIndex + Int((topIndex - bottomIndex)/2)
            } else if lowerBound < sampleLowerBound {
                if lowerBound > ranges[sampleIndex - 1].lowerBound {
                    // We're at threshold
                    return sampleIndex - 1
                }
                
                topIndex = sampleIndex
                sampleIndex = bottomIndex + Int((topIndex - bottomIndex)/2)
            }
        }
        
        return nil
    }
}
