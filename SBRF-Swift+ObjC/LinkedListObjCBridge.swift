//
//  LinkedListObjCBridge.swift
//  SBRF-Swift+ObjC
//
//  Created by Artem Balashov on 15/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

import Foundation

@objc class LinkedListObjC: NSObject {
    private var list: LinkedList<Any?>
    
    override init() {
        list = LinkedList<Any?>()
        super.init()
    }
    
    @objc public var count: Int {
        return list.count
    }
    
    @objc public var isEmpty: Bool {
        return list.isEmpty
    }
    
    @discardableResult
    @objc func append(_ element: Any?) -> NSError? {
        list.append(element)
        return nil
    }
    
    @objc func element(at index: Int) -> Any? {
        return list.element(at: index)?.flatMap{$0}
    }
}
