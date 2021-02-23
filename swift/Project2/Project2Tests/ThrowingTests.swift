//
//  ThrowingTests.swift
//  Project2Tests
//
//  Created by Jinwoo Kim on 2/24/21.
//

import XCTest
@testable import Project2

enum GameError: Error {
    case notPurchased, notInstalled, parentalControlsDisallowed
}

struct Game: LocalizedError {
    let name: String
    
    func play() throws {
        if name == "BioBlitz" {
            throw GameError.notPurchased
        } else if name == "Blastazap" {
            throw GameError.notInstalled
        } else if name == "Dead Storm Rising" {
            throw GameError.parentalControlsDisallowed
        } else {
            print("\(name) is OK to play!")
        }
    }
}

// 나오는 에러 문구를 더 깔끔하게 만들어준다.
extension LocalizedError {
    var errorDescription: String? {
        return "\(self)"
    }
}

class ThrowingTests: XCTestCase {
    func testPlayingBioBlitzThrows() {
        let game = Game(name: "BioBlitz")
        
        do {
            try game.play()
            XCTFail("BioBlitz has not been purchased.")
        } catch GameError.notPurchased {
            // success!
        } catch {
            XCTFail()
        }
    }
    
    // 위 method를 요약하면
    func testPlayingBlastazapThrows() {
        let game = Game(name: "Blastazap")
        XCTAssertThrowsError(try game.play())
    }
    
    // 위 method를 요약하면
    func testPlayingBlastazapThrows2() {
        let game = Game(name: "Blastazap")
        XCTAssertThrowsError(try game.play()) { error in
            // Error Handling
            XCTAssertEqual(error as? GameError, GameError.notInstalled)
        }
    }
    
    // 에러가 없을 경우에만 Pass
    func testPlayingExplodingMonkeysDoesntThrow() {
        let game = Game(name: "Exploding Monkeys")
        XCTAssertNoThrow(try game.play())
    }
    
    // 에러가 없을 경우에만 Pass
    func testDeadStornRisingThrows() throws {
        let game = Game(name: "Dead Storm Rising")
        try game.play()
    }
    
    func testCrashyPlaneDoesntThrow() throws {
        let game = Game(name: "CrashyPlane")
        try game.play()
    }
}
