//
//  NSPredicateTest.m
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import <XCTest/XCTest.h>

@interface TestClass1 : NSObject
@property NSString * _Nullable name;
@end

@implementation TestClass1
- (TestClass1 *)initWithName:(NSString * _Nullable)name {
    self = [super init];
    if (self) self.name = name;
    return self;
}
@end

@interface NSPredicateTest : XCTestCase

@end

@implementation NSPredicateTest
- (void)testPredicate {
    TestClass1 *testClass1 = [[TestClass1 alloc] initWithName:nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name != nil"];
    XCTNSPredicateExpectation *expectation = [[XCTNSPredicateExpectation alloc] initWithPredicate:predicate object:testClass1];
    
    // 3초동안 기다려도 predicate가 YES가 안 나올 경우 Fail
    [self waitForExpectations:@[expectation] timeout:3];
}
@end
