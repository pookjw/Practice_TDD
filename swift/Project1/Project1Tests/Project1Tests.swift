//
//  Project1Tests.swift
//  Project1Tests
//
//  Created by Jinwoo Kim on 2/22/21.
//

import XCTest

// Xcode 프로젝트는 기본적으로 internal proection level을 쓰고 있어서, 외부 module에서는 접근이 불가능하다. 하지만 @testable을 쓸 경우 테스트 기능 한정으로 접근이 가능해진다.
@testable import Project1

class Project1Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // 예제
        XCTAssertTrue(2 == 3)
        XCTAssertEqual(2, 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func DISABLED_testHaterStartsNicely() {
        let hater = Hater()
        
        XCTAssertFalse(hater.hating)
    }
    
    func testHaterHatesAfterBadDay() {
        var hater = Hater()
        
        hater.hadABadDay()
        
        XCTAssertTrue(hater.hating)
    }

    func DISABLED_testHaterHappyAfterGoodDay() {
        var hater = Hater()
        
        hater.hadAGoodDay()
        
        XCTAssertFalse(hater.hating)
    }
    
    func willThisRun() {
        print("Hi!")
    }
    
    func testHaterStartsNicely() {
        let hater = Hater()
        XCTAssertFalse(hater.hating, "New Haters should not be hating.")
    }
    
    func testHaterHappyAfterGoodDay() {
        // Given
        var hater = Hater()
        
        // When
        hater.hadAGoodDay()
        
        // Then
        XCTAssertFalse(hater.hating)
    }
    
    // 가장 먼저 불린다
    override class func setUp() {
        
    }
    
    // Test가 끝나고 정리
    override class func tearDown() {
//
    }
    
    /*
     setUp -> testHaterStartsNicely -> tearDown
     setUp -> testHaterHatesAfterBadDay -> tearDown
     setUp -> testHaterHappyAfterGoodDay -> tearDown
     이런 식으로 불린다고 한다. 알파벳 순서.
     
     test를 하기 위해서는
     1. method 이름이 test로 시작해야 하며
     2. parameters가 없어야 하며
     3. return되는 것도 없어야 한다.
     
     Test를 끄기 위해 method 이름 앞에 DISABLED, INACTIVE, SKIP, DEAD, BROKEN을 쓴다. DISABLED_testDKEKKDK 등.
     */
}
