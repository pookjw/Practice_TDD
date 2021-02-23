//
//  LifecycleTests.swift
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

import XCTest

// Error가 발생해도 tearDown Life Cycle은 그대로 돌아감 - test는 안 돌아감
class LifecycleTests: XCTestCase {
    override class func setUp() {
        print(#function)
    }
    
    override class func tearDown() {
        print(#function)
    }
    
    override func setUp() {
        print(#function)
    }
    
    override func tearDown() {
        print(#function)
    }
    
    override func setUpWithError() throws {
        print(#function)
    }
    
    override func tearDownWithError() throws {
        print(#function)
    }
    
    func testExample() {
        print(#function)
        
        addTeardownBlock {
            print("In first tearDown block.")
        }
        
        print(#function)
    }
}
