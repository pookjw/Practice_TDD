//
//  Project2Tests.swift
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/22/21.
//

import XCTest
@testable import Project2

class Project2Tests: XCTestCase {
    
    override class func setUp() {
        print(#function)
    }
    
    override class func tearDown() {
        print(#function)
    }

    override func setUpWithError() throws {
        print(#function)
        
        // fail 뜨면 멈춤
//        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        print(#function)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFahrenheitToCelsius() {
        // given
        let sut = Converter()
        let input1 = 32.0
        let input2 = 212.0
        
        // when
        let output1 = sut.convertToCelsius(fahrenheit: input1)
        let output2 = sut.convertToCelsius(fahrenheit: input2)
        
        // then
        XCTAssertEqual(output1, 0)
        XCTAssertEqual(output2, 100)
    }
    
    func test32FahrenheitIsZeroCelsius() {
        // given
        let sut = Converter()
        let input = 32.0
        
        // when
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // then
        XCTAssertEqual(celsius, 0)
        XCTAssertEqual(celsius, 0, accuracy: 0.000001)
    }

    func test212FahrenheitIs100Celsius() {
        // given
        let sut = Converter()
        let input = 212.0
        
        // when
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // then
        XCTAssertEqual(celsius, 100)
        XCTAssertEqual(celsius, 100, accuracy: 0.000001)
    }
    
    func testViewController() {
        let vc = ViewController()
        vc.loadViewIfNeeded()
        vc.viewWillAppear(false)
        vc.viewDidAppear(false)
        
        XCTAssertNotNil(vc.returnNonNilStr())
    }
}
