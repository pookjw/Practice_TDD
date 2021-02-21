//
//  Project1Tests.m
//  Project1Tests
//
//  Created by Jinwoo Kim on 2/22/21.
//

#import <XCTest/XCTest.h>
#import "Hater.h"

@interface Project1Tests : XCTestCase

@end

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

@implementation Project1Tests


// 가장 먼저 불린다
- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

// Test가 끝나고 정리
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertTrue(2 == 3);
    XCTAssertEqual(2, 3);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)DISABLED_testHaterStartsNicely {
    Hater *hater = [Hater new];
    XCTAssertFalse(hater.hating);
}

- (void)DISABED_testHaterHappyAfterGoodDay {
    Hater *hater = [Hater new];
    [hater hadAGoodDay];
    XCTAssertFalse(hater.hating);
}

- (void)willThisRun {
    NSLog(@"Hi");
}

- (void)testHaterStartsNicely {
    Hater *hater = [Hater new];
    XCTAssertFalse(hater.hating, @"New Haters should not be hating.");
}

- (void)testHaterHappyAfterGoodDay {
    // Given
    Hater *hater = [Hater new];
    
    // When
    [hater hadAGoodDay];
    
    // Then
    XCTAssertFalse(hater.hating);
}

@end
