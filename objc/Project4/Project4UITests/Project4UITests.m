//
//  Project4UITests.m
//  Project4UITests
//
//  Created by Jinwoo Kim on 2/25/21.
//

#import <XCTest/XCTest.h>

@interface Project4UITests : XCTestCase

@end

@implementation Project4UITests

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (XCUIApplication *)runApp {
    XCUIApplication *app = [XCUIApplication new];
    app.launchArguments = @[@"enable-testing"];
    [app launch];
    return app;
}

- (void)testExample {
    [self runApp];
}

- (void)testExample2 {
    XCUIApplication *app = [self runApp];
    [app.textFields.element tap];
    
    [app.keys[@"t"] tap];
    [app.keys[@"e"] tap];
    [app.keys[@"s"] tap];
    [app.keys[@"t"] tap];
    
    [app.keyboards.buttons[@"Return"] tap];
    // 현재 Slider가 50%인걸 찾아낸다. 정확한 값으로 슬라이드 하고 싶으면 adjustToNormalizedSliderPosition를 쓸 것 (testSliderControls 참조)
    [app.sliders[@"50%"] swipeRight];
    [app.segmentedControls.buttons[@"Omega"] tap];
    [app.buttons[@"Blue"] tap];
    [app.alerts[@"Blue"].buttons[@"OK"] tap];
}

- (void)testLabelCopiesTextField {
    XCUIApplication *app = [self runApp];
    [app.textFields.element tap];
    
    [app.keys[@"t"] tap];
    [app.keys[@"e"] tap];
    [app.keys[@"s"] tap];
    [app.keys[@"t"] tap];
    
    [app.keyboards.buttons[@"Return"] tap];
    
    // Storyboard에 정으된 Accessibility Identifier이다.
    [app.sliders[@"Completion"] swipeRight];
    
    // 아래 테스트는 오류가 난다. 화면에는 수많은 Static Text들이 있기 때문.
//    XCTAssertEqual(app.staticTexts.element.label, @"test");
    
    // NSString은 Swift 처럼 하면 안 된다.
//    XCTAssertEqual(app.staticTexts[@"TextCopy"].label, @"test");
    
    // 이렇게 해야 한다.
    XCTAssertTrue([app.staticTexts[@"TextCopy"].label isEqualToString:@"test"]);
}

- (void)testSliderControls {
    XCUIApplication *app = [self runApp];
    [app.sliders[@"Completion"] adjustToNormalizedSliderPosition:1];
    
    NSString *completion = app.progressIndicators.element.value;
    if (completion == nil) {
        XCTFail(@"Unable to find the progress indicator");
        return;
    }
    
    XCTAssertTrue([completion isEqualToString:@"0%"]);
}

- (void)testButtonsShowAlerts {
    XCUIApplication *app = [self runApp];
    [app.buttons[@"Blue"] tap];
    XCTAssertTrue(app.alerts[@"Blue"].exists);
    [app.alerts[@"Blue"].buttons[@"OK"] tap];
}

- (void)testButtonsShowAlerts2 {
    XCUIApplication *app = [self runApp];
    [app.buttons[@"Blue"] tap];
    XCTAssertTrue([app.alerts[@"Blue"] waitForExistenceWithTimeout:1]);
    [app.alerts[@"Blue"].buttons[@"OK"] tap];
}

- (void)testExample3 {
    XCUIApplication *app = [self runApp];
    [app.textFields.element tap];
    
    [app.textFields.element typeText:@"test"];
    [app.keyboards.buttons[@"Return"] tap];
    [app.sliders[@"50%"] swipeRight];
    [app.segmentedControls.buttons[@"Omega"] tap];
    [app.buttons[@"Blue"] tap];
    [app.alerts[@"Blue"].buttons[@"OK"] tap];
    
    // 아래 코드는 실패한다. 실패할 경우 자동으로 스크린샷 찍어준다. Scheme Settings에서 설정 가능.
    XCTAssertTrue(app.alerts[@"Blue"].exists);
}

- (void)testScreenShot {
    XCUIApplication *app = [self runApp];
    XCUIScreenshot *screenshot = [app screenshot];
    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:screenshot];
    attachment.name = @"My Great Screenshot";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways; // 또는 XCTAttachmentLifetimeDeleteOnSuccess
    [self addAttachment:attachment];
}

- (void)testUIInterruption {
    [self runApp];
    [self addUIInterruptionMonitorWithDescription:@"Automatically allow location permissions"
                                          handler:^BOOL(XCUIElement * _Nonnull interruptingElement) {
        [interruptingElement.buttons[@"OK"] tap];
        return YES;
    }];
}

@end
