//
//  LinkedList.swift
//  SBRF-Swift+ObjC
//
//  Created by Artem Balashov on 15/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

import Foundation

protocol Container {
    associatedtype Value
    var count: Int {get}
    mutating func append(_ element: Value)
    func element(at index: Int) -> Value?
}

// MARK: - LinkedList

class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

extension LinkedListNode: CustomStringConvertible {
    public var description: String {
        return "LinkedListNode<\(T.self)>; value: \(self.value); next: \(self.next?.simpleDescription ?? "nil"); previous: \(self.previous?.simpleDescription  ?? "nil")"
    }
    
    public var simpleDescription: String {
        return "LinkedListNode<\(T.self)>; value: \(self.value);"
    }
}

struct LinkedList<T>: Container {
    typealias Value = T
    
    private var head: LinkedListNode<T>?
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    public var first: LinkedListNode<T>? {
        return head
    }
    
    public var last: LinkedListNode<T>? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    mutating func append(_ element: Value) {
        let newNode = LinkedListNode(value: element)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    func element(at index: Int) -> Value? {
        return node(at: index)?.value
    }
    
    func node(at index: Int) -> LinkedListNode<T>? {
        if index == 0 {
            return head
        } else {
            var node = head?.next
            for _ in 1..<index {
                node = node?.next
                if node == nil { //(*1)
                    break
                }
            }
            return node
        }
    }
    
    public subscript(index: Int) -> LinkedListNode<T>? {
        return self.node(at: index)
    }
    
    static func +=(lhs: inout LinkedList, rhs: LinkedList) {
        var rhsNode = rhs.head
        var lhsLastNode = lhs.last
        while let node = rhsNode {
            lhsLastNode?.next = node
            lhsLastNode = node
            rhsNode = rhsNode?.next
        }
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "LinkedList<\(Value.self)>["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
}

extension LinkedList: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Value
    init(arrayLiteral elements: LinkedList.ArrayLiteralElement...) {
        elements.forEach {append($0)}
    }
    
    init(_ elements: [T]) {
        elements.forEach {append($0)}
    }
}
