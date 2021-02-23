//
//  Project2Tests.m
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import <XCTest/XCTest.h>
#import "Converter.h"
#import "ViewController.h"

@interface Project2Tests : XCTestCase

@end

@implementation Project2Tests

// NO이면 테스트 안함 - tearDown Life Cycle은 그대로 돌아감. Error가 발생할 때도 마찬가지
- (BOOL)setUpWithError:(NSError *__autoreleasing  _Nullable *)error {
    // fail 뜨면 멈춤
//    self.continueAfterFailure = NO;
    return YES;
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testFahrenheitToCelsius {
    // given
    Converter *sut = [Converter new];
    double input1 = 32.0;
    double input2 = 212.0;
    
    // when
    double output1 = [sut convertToCelsiusFromFahrenheit:input1];
    double output2 = [sut convertToCelsiusFromFahrenheit:input2];
    
    // then
    XCTAssertEqual(output1, 0);
    XCTAssertEqual(output2, 100);
}

- (void)test32FahrenheitIsZeroCelsius {
    // given
    Converter *sut = [Converter new];
    double input = 32.0;
    
    // when
    double celsius = [sut convertToCelsiusFromFahrenheit:input];
    
    // then
//    XCTAssertEqual(celsius, 0);
//    XCTAssertEqual(celsius, 0, 0.000001);
    XCTAssertEqualWithAccuracy(celsius, 0, 0.000001);
}

- (void)test212FahrenheitIs100Celsius {
    // given
    Converter *sut = [Converter new];
    double input = 212.0;
    
    // when
    double celsius = [sut convertToCelsiusFromFahrenheit:input];
    
    // then
    XCTAssertEqualWithAccuracy(celsius, 100, 0.000001);
}

- (void)testViewController {
    ViewController *vc = [ViewController new];
    [vc loadViewIfNeeded];
    [vc viewWillAppear:NO];
    [vc viewDidAppear:NO];
    
    XCTAssertNotNil([vc returnNonNilStr]);
}

@end
