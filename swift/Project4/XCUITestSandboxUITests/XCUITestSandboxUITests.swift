//
//  XCUITestSandboxUITests.swift
//  XCUITestSandboxUITests
//
//  Created by Jinwoo Kim on 2/25/21.
//  Copyright © 2021 Hacking with Swift. All rights reserved.
//

import XCTest

class XCUITestSandboxUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    @discardableResult
    func runApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        return app
    }
    
    func testExample() throws {
        runApp()
    }
    
    func testExample2() {
        let app = runApp()
        app.textFields.element.tap()
        
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        
        app.keyboards.buttons["Return"].tap()
        // 현재 Sldier가 50%인걸 찾아낸다.
        app.sliders["50%"].swipeRight()
        app.segmentedControls.buttons["Omega"].tap()
        app.buttons["Blue"].tap()
        app.alerts["Blue"].buttons["OK"].tap()
    }
    
    func testLabelCopiesTextField() {
        let app = runApp()
        app.textFields.element.tap()
        
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        
        app.keyboards.buttons["Return"].tap()
        
        // Storyboard에 정의된 Accessibility Identifier이다.
        app.sliders["Completion"].swipeRight()
        
        // 아래 테스트는 오류가 난다. 화면에는 수많은 Text들이 있기 때문.
//        XCTAssertEqual(app.staticTexts.element.label, "test")
        
        // Storyboard에 정의된 Accessibility Identifier이다.
        XCTAssertEqual(app.staticTexts["TextCopy"].label, "test")
        
    }
    
    func testSliderControls() {
        let app = runApp()
        app.sliders["Completion"].adjust(toNormalizedSliderPosition: 1)
        
        guard let completion = app.progressIndicators.element.value as? String else {
            XCTFail("Unable to find the progress indicator.")
            return
        }
        
        XCTAssertEqual(completion, "0%")
    }
    
    func testButtonsShowAlerts() {
        let app = runApp()
        app.buttons["Blue"].tap()
        XCTAssertTrue(app.alerts["Blue"].exists)
        app.alerts["Blue"].buttons["OK"].tap()
    }
    
    func testButtonsShowAlerts2() {
        let app = runApp()
        app.buttons["Blue"].tap()
        XCTAssertTrue(app.alerts["Blue"].waitForExistence(timeout: 1))
        app.alerts["Blue"].buttons["OK"].tap()
    }
    
    func testExample3() {
        let app = runApp()
        app.textFields.element.tap()
        
        app.textFields.element.typeText("test")
        app.keyboards.buttons["Return"].tap()
        app.sliders["50%"].swipeRight()
        app.segmentedControls.buttons["Omega"].tap()
        app.buttons["Blue"].tap()
        app.alerts["Blue"].buttons["OK"].tap()
        
        // 아래 코드는 실패한다. 실패할 경우 자동으로 스샷 찍어준다. Scheme Settings에서 설정 가능.
        XCTAssertTrue(app.alerts["Blue"].exists)
    }
    
    func testScreenShot() {
        let app = runApp()
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "My Great Screenshot"
        attachment.lifetime = .keepAlways //  또는 .deleteOnSuccess
        add(attachment)
    }
    
    func testUIInterruption() {
        runApp()
        addUIInterruptionMonitor(withDescription: "Automatically allow location permissions") { alert in
            alert.buttons["OK"].tap()
            return true
        }
    }
}
