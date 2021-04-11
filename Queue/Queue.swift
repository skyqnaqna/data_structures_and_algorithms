//
//  Queue.swift
//  learnSwift
//
//  Created by Subin Kim on 2021/04/08.
//

public protocol Queue {
  associatedtype Element
  mutating func enqueue (_ element: Element) -> Bool
  mutating func dequeue () -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}

// 1. Using an array
// 2. Using a doubly linked list
// 3. Using a ring buffer
// 4. Using two stacks

// Array based implementation
public struct QueueArray<T>: Queue {
  private var array: [T] = []
  public init() {}
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var peek: T? {
    return array.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    array.append(element)
    return true
  }
  
  public mutating func dequeue() -> T? {
    return isEmpty ? nil : array.removeFirst()
  }
}

extension QueueArray: CustomStringConvertible {
  public var description: String {
    return array.description
  }
}

// Doubly linked list implementation

public class QueueLinkedList<T>: Queue {
  private var list = DoublyLinkedList<T>()
  public init() {}
  
  public func enqueue (_ element: T) -> Bool {
    list.append(element)
    return true
  }
  
  public func dequeue() -> T? {
    guard !list.isEmpty, let element = list.first else {
      return nil
    }
    return list.remove(element)
  }
  
  public var peek: T? {
    return list.first?.value
  }
  
  public var isEmpty: Bool {
    return list.isEmpty
  }
}

extension QueueLinkedList: CustomStringConvertible {
  public var description: String {
    return list.description
  }
}

// Ring buffer implementation

public struct QueueRingBuffer<T>: Queue {
  private var ringBuffer: RingBuffer<T>
  
  public init (count: Int) {
    ringBuffer = RingBuffer<T>(count: count)
  }
  
  public var isEmpty: Bool {
    return ringBuffer.isEmpty
  }
  
  public var peek: T? {
    return ringBuffer.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    return ringBuffer.write(element)
  }
  
  public mutating func dequeue() -> T? {
    return isEmpty ? nil : ringBuffer.read()
  }
}

extension QueueRingBuffer: CustomStringConvertible {
  public var description: String {
    return ringBuffer.description
  }
}

// Double stack implementation

public struct QueueStack<T>: Queue {
  private var leftStack: [T] = []
  private var rightStack: [T] = []
  public init () {}
  
  public var isEmpty: Bool {
    return leftStack.isEmpty && rightStack.isEmpty
  }
  
  public var peek: T? {
    return !leftStack.isEmpty ? leftStack.last : rightStack.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    rightStack.append(element)
    return true
  }
  
  public mutating func dequeue() -> T? {
    if leftStack.isEmpty {
      leftStack = rightStack.reversed()
      rightStack.removeAll()
    }
    return leftStack.popLast()
  }
}

extension QueueStack: CustomStringConvertible {
  public var description: String {
    let printList = leftStack + rightStack.reversed()
    return printList.description
  }
}
