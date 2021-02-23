//
//  AsynchronousTests.m
//  AsynchronousTests
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import <XCTest/XCTest.h>

void calculatePrime(NSUInteger max, void(^completion)(NSArray<NSNumber *> *primes)) {
    // push our work straight to a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // if the input value is 0 or 1 exit immediately
        if (max < 2) return;
        
        // mark all our numbers as prime
        NSMutableArray<NSNumber *> *sieve = [@[] mutableCopy];
        for (NSUInteger idx = 0; idx < max; idx++) {
            [sieve addObject:[NSNumber numberWithBool:YES]];
        }
        
        // 0 and 1 are by definition not prime
        sieve[0] = [NSNumber numberWithBool:NO];
        sieve[1] = [NSNumber numberWithBool:NO];
        
        // count from 0 up to the ceiling...
        for (NSUInteger number = 2; number < max; number++) {
            // if this is marked as prime, then every multiple of it is not prime
            if ([sieve[number] boolValue] == YES) {
                NSUInteger strideInteger = number * number;
                while (strideInteger < sieve.count) {
                    sieve[strideInteger] = [NSNumber numberWithBool:NO];
                    strideInteger += number;
                }
            }
        }
        
        // collapse our results down to a single array of primes
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSNumber *number = (NSNumber *)evaluatedObject;
            if (number == nil) return NO;
            return [number boolValue];
        }];
        [sieve filterUsingPredicate:predicate];
        completion([sieve copy]);
    });
}

@interface AsynchronousTests : XCTestCase

@end

@implementation AsynchronousTests

- (void)testPrimesUpTo100ShouldBe0 {
    // given
    NSUInteger maximumCount = 100;
    
    // when
    calculatePrime(maximumCount, ^(NSArray<NSNumber *> *primes) {
        // then
        XCTAssertEqual(primes.count, 0);
    });
}

- (void)testPrimesUpTo100ShouldBe0Fix {
    // given
    NSUInteger maximumCount = 100;
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:[NSString stringWithFormat:@"Calculate primes up to %lu", maximumCount]];
    
    // when
    calculatePrime(maximumCount, ^(NSArray<NSNumber *> *primes) {
        // then
        XCTAssertEqual(primes.count, 0);
        [expectation fulfill];
    });
    
    [self waitForExpectations:@[expectation] timeout:10];
}

@end
