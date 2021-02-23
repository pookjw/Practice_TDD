//
//  NotificationTest.swift
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

import XCTest

struct User {
    static let upgradedNotification = Notification.Name("UserUpgraded")
    
    func upgrade() {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            let center = NotificationCenter.default
            center.post(name: User.upgradedNotification, object: nil)
        }
    }
    
    func upgrade2() {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            let center = NotificationCenter.default
            center.post(name: User.upgradedNotification, object: nil, userInfo: ["level": "gold"])
        }
    }
    
    // default는 Singleton이므로 충돌을 방지하기 위해 Test에서는 쓰지 말자.
    func upgrade3(using center: NotificationCenter = NotificationCenter.default) {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            center.post(name: User.upgradedNotification, object: nil, userInfo: ["level": "gold"])
        }
    }
}

class NotificationTest: XCTestCase {
    // 3초동안 Notification 알림을 기다려보고 안 오면 Fail
    func testUserUpgradedPostsNotification() {
        // given
        let user = User()
        // notificationCenter에 대한 정의가 없으면 default를 옵저빙한다.
        let expectation = XCTNSNotificationExpectation(name: User.upgradedNotification)
        
        // when
        user.upgrade()
        
        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testUserUpgradedPostsNotification2() {
        // given
        let user = User()
        // notificationCenter에 대한 정의가 없으면 default를 옵저빙한다.
        let expectation = XCTNSNotificationExpectation(name: User.upgradedNotification)
        
        // 들어온 Notification에 따라 false이면 Fail, true이면 Pass
        expectation.handler = { notification -> Bool in
            guard let level = notification.userInfo?["level"] as? String else {
                return false
            }
            
            if level == "gold" {
                return true
            } else {
                return false
            }
        }
        
        // when
        user.upgrade2()
        
        // then
        wait(for: [expectation], timeout: 3)
    }
    
    func testUserUpgradePostsNotification3() {
        // given
        let center = NotificationCenter()
        let user = User()
        let expectation = XCTNSNotificationExpectation(name: User.upgradedNotification, object: nil, notificationCenter: center)
        
        expectation.handler = { notification -> Bool in
            guard let level = notification.userInfo?["level"] as? String else {
                return false
            }
            
            if level == "gold" {
                return true
            } else {
                return false
            }
        }
        
        // when
        user.upgrade3(using: center)
        
        // then
        wait(for: [expectation], timeout: 3)
    }
}
