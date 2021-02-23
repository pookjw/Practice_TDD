//
//  LifeCycleTests.m
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import <XCTest/XCTest.h>

@interface LifeCycleTests : XCTestCase

@end

@implementation LifeCycleTests

+ (void)setUp {
    NSLog(@"[Static] setUp");
}

- (void)setUp {
    NSLog(@"setUp");
}

- (BOOL)setUpWithError:(NSError *__autoreleasing  _Nullable *)error {
    NSLog(@"setUpWithError");
    *error = [[NSError alloc] initWithDomain:@"TestError" code:1003 userInfo:@{NSLocalizedDescriptionKey: @"Localized Test Error!"}];
    return NO; // NO이면 테스트 안함 - tearDown Life Cycle은 그대로 돌아감. Error가 발생할 때도 마찬가지
}

//

+ (void)tearDown {
    NSLog(@"[Static] tearDown");
}

- (void)tearDown {
    NSLog(@"tearDown");
}

- (BOOL)tearDownWithError:(NSError *__autoreleasing  _Nullable *)error {
    NSLog(@"tearDownWithError");
    return NO; // NO여도 + (void)tearDown은 돌아감. Error가 발생할 때도 마찬가지
}

//

- (void)testExample {
    NSLog(@"testExample");
}

@end
