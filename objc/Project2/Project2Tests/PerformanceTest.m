//
//  PerformanceTest.m
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import <XCTest/XCTest.h>

NSArray * calculatePrime(NSUInteger max) {
    // if the input value is 0 or 1 exit immediately
    if (max < 2) return @[];
    
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
    
    return [sieve copy];
}

@interface PerformanceTest : XCTestCase

@end

@implementation PerformanceTest
- (void)testPrimePerformance {
    [self measureBlock:^{
        calculatePrime(1000000);
    }];
}
@end
