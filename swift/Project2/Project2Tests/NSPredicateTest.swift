//
//  NSPredicateTest.swift
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

import XCTest

class TestClass1: NSObject {
    @objc var name: NSString? = nil
}

class NSPredicateTest: XCTestCase {
    func testPredicate() {
        let testClass1: TestClass1 = .init()
        let predicate = NSPredicate(format: "name == nil")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: testClass1)
        
        // 3초 동안 기다려도 predicate가 true가 안 나올 경우 Fail
        wait(for: [expectation], timeout: 3)
    }
}
