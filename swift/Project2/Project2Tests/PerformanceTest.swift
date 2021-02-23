//
//  PerformanceTest.swift
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

import XCTest

struct PrimeCalculator {
    static func calculate(upTo max: Int) -> [Int] {
        guard max > 1 else {
            // if the input value is 0 or 1 exit immediately
            return []
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
        
        return primes
    }
}

class PerformanceTest: XCTestCase {
    func testPrimePerformance() {
        measure {
            _ = PrimeCalculator.calculate(upTo: 1_000_000)
        }
    }
}
