//
//  Deque.swift
//  learnSwift
//
//  Created by Subin Kim on 2021/04/11.
//

public struct Deque<T> {
  private var array: [T?]
  private var head: Int
  private var size: Int
  private var capacity: Int

  public init (_ size: Int = 10) {
    self.size = max(size, 1)
    capacity = self.size
    array = [T?](repeating: nil, count: size)
    head = size
  }

  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }

  public mutating func push(_ element: T) {
    array.append(element)
  }

  public mutating func pushLeft(_ element: T) {
    if head == 0 {
      size *= 2
      let temp = [T?](repeating: nil, count: size)
      array.insert(contentsOf: temp, at: 0)
      head = size
    }

    head -= 1
    array[head] = element
  }

  public mutating func pop() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.removeLast()
    }
  }

  public mutating func popLeft() -> T? {
    guard head < array.count, let element = array[head] else { return nil }

    array[head] = nil
    head += 1

    if size >= capacity && head >= size * 2 {
      let amountToRemove = size + size / 2
      array.removeFirst(amountToRemove)
      head -= amountToRemove
      size /= 2
    }

    return element
  }

  public func peekLeft() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.last!
    }
  }

  public func peek() -> T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}