//
//  NotificationTest.m
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

#import <XCTest/XCTest.h>

static NSNotificationName upgradedNotification = @"UserUpgraded";

@interface User : NSObject
- (void)upgrade;
- (void)upgrade2;
- (void)upgrade3Using:(NSNotificationCenter *)center;
@end

@implementation User
- (void)upgrade {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
        [center postNotificationName:upgradedNotification object:nil];
    });
}

- (void)upgrade2 {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
        [center postNotificationName:upgradedNotification object:nil userInfo:@{@"level": @"gold"}];
    });
}

// default는 Singleton이므로 충돌을 방지하기 위해 Test에서는 쓰지 말자.
- (void)upgrade3Using:(NSNotificationCenter *)center {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1];
        [center postNotificationName:upgradedNotification object:nil userInfo:@{@"level": @"gold"}];
    });
}
@end

@interface NotificationTest : XCTestCase
@end

@implementation NotificationTest
// 3초동안 Notification을 기다려보고 안 오면 Fail
- (void)testUserUpgradedPostsNotification {
    // given
    User *user = [User new];
    // notificationCenter에 대한 정의가 없으면 default를 옵저빙한다.
    XCTNSNotificationExpectation *expectation = [[XCTNSNotificationExpectation alloc] initWithName:upgradedNotification];
    
    // when
    [user upgrade];
    
    // then
    [self waitForExpectations:@[expectation] timeout:3];
}

- (void)testUserUpgradedPostsNotification2 {
    // given
    User *user = [User new];
    // notificationCenter에 대한 정의가 없으면 default를 옵저빙한다.
    XCTNSNotificationExpectation *expectation = [[XCTNSNotificationExpectation alloc] initWithName:upgradedNotification];
    
    // 들어온 Notification에 따라 NO이면 Fail, YES이면 Pass
    [expectation setHandler:^BOOL(NSNotification * _Nonnull notification) {
        NSString *level = notification.userInfo[@"level"];
        if (level == nil) return NO;
        
        if ([level isEqualToString:@"gold"]) {
            return YES;
        } else {
            return NO;
        }
    }];
    
    // when
    [user upgrade2];
    
    // then
    [self waitForExpectations:@[expectation] timeout:3];
}

- (void)testUserUpgradedPostsNotification3 {
    // given
    NSNotificationCenter *center = [NSNotificationCenter new];
    User *user = [User new];
    XCTNSNotificationExpectation *expectation = [[XCTNSNotificationExpectation alloc] initWithName:upgradedNotification object:nil notificationCenter:center];
    
    // 들어온 Notification에 따라 NO이면 Fail, YES이면 Pass
    [expectation setHandler:^BOOL(NSNotification * _Nonnull notification) {
        NSString *level = notification.userInfo[@"level"];
        if (level == nil) return NO;
        
        if ([level isEqualToString:@"gold"]) {
            return YES;
        } else {
            return NO;
        }
    }];
    
    // when
    [user upgrade3Using:center];
    
    // then
    [self waitForExpectations:@[expectation] timeout:3];
}

@end
