//
//  AsynchronousTests.swift
//  AsynchronousTests
//
//  Created by Jinwoo Kim on 2/24/21.
//

import XCTest
@testable import Project2

struct PrimeCalculator {
    static func calculate(upTo max: Int, completion: @escaping ([Int]) -> Void) {
        // push our work straight to a background thread
        DispatchQueue.global().async {
            guard max > 1 else {
                // if the input value is 0 or 1 exit immediately
                return
            }
            
            // mark all our numbers as prime
            var sieve = [Bool](repeating: true, count: max)
            
            // 0 and 1 are by definition not prime
            sieve[0] = false
            sieve[1] = false
            
            // count from 0 up to the ceiling...
            for number in 2..<max {
                // if this is marked as prime, then every multiple of it is not prime
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                }
            }
            
            // collapse our results down to a single array of primes
            let primes = sieve.enumerated().compactMap { $1 == true ? $0 : nil }
            
            completion(primes)
        }
    }
}

class AsynchronousTests: XCTestCase {
    func testPrimesUpTo100ShouldBe0() {
        // given
        let maximumCount = 5000
        
        // when
        PrimeCalculator.calculate(upTo: maximumCount) {
            // then
            XCTAssertEqual($0.count, 0)
        }
    }
    
    func testPrimesUpTo100ShouldBe0Fix() {
        // given
        let maximumCount = 5000
        let expectation = XCTestExpectation(description: "Calculate primes up to \(maximumCount)")
        
        // when
        PrimeCalculator.calculate(upTo: maximumCount) {
            // then
            XCTAssertEqual($0.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
