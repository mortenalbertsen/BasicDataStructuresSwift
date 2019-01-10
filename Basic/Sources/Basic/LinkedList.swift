protocol LinkedList : Sequence {
    associatedtype Element
    
    mutating func append(item: Element)
    func contains(element: Element) -> Bool
    
    var count : Int { get }
}

struct LinkedListImplementation<T:Equatable> : LinkedList  {
    
    private (set) var count : Int

    private (set) var head : SomeLink<T>?
    private var tail : SomeLink<T>?

    mutating func append(item: T) {
        let toBeAttached = SomeLink(item)
        if let currentTail = self.tail {
            currentTail.append(toBeAttached)
        }
        self.tail = toBeAttached

        self.count = self.count + 1
    }
    
    func contains(element: T) -> Bool {
        for elementInList in self {
            if elementInList == element {
                return true
            }
        }
        return false
    }
}

extension LinkedListImplementation : Sequence {
    public func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(linkedList: self)
    }
}

class LinkedListIterator<Element:Equatable> : IteratorProtocol {
    var nextElement : Element?

    init(linkedList: LinkedListImplementation<Element>) {
        self.nextElement = linkedList.head?.containedElement
    }
    
    func next() -> Element? {
        return nil // TODO: Fix!
    }
}

// extension LinkedListImplementation : Sequence {
//     func makeIterator() -> LinkedListIterator<Item> {
//         return LinkedListIterator(linkedList: self)
//     }
// }

// struct LinkedListIterator<Item:Link.Element> : IteratorProtocol {

//     var returnNext: Item?

//     init(linkedList: LinkedListImplementation<Item>) {
//         self.returnNext = linkedList.firstElement
//     }

//     mutating func next() -> Item? {
//         guard let toReturn = self.returnNext else {
//             return nil
//         }
//         self.returnNext = toReturn.next
//         return toReturn
        
//     }
// }

// A Link wraps an Element
protocol Link {
    associatedtype Element
    var next : Self? { get set}
    var wrappedElement : Element { get }
    func append(item: Element)
}

class SomeLink<Item> {
    var containedElement : Item
    var next: SomeLink<Item>?

    init(_ containedElement:Item, withSuccessor successor: SomeLink<Item>? = nil) {
        self.containedElement = containedElement
        self.next = successor
    }

    func append(_ item: SomeLink<Item>) {
        self.next = item
    }
    
}

// struct LinkImplementation: Link {

//     var item : Element
//     var next : Element? = nil

//     var isLastElement : Bool {
//         get {
//             return next != nil
//         }
//     }
// }
