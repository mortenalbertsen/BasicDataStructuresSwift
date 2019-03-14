# BasicDataStructuresSwift
Basic data-structures written in Swift (contained in Xcode-project)



Current datastructures in project

- Class `RangeCollection<T:Comparable>` manages a collection of ranges.

  Supported operations are

  - `insert(range: Range<T>) -> Bool`
    Note: If to-be inserted range overlaps with existing range(s), these are merged into and replaced by a single range. 
  - `contains(element: T) -> Bool`

