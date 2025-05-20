//
//  CharacterListViewUITests.swift
//  MyRickAndMorty
//
//  Created by Miguel @Private on 21.05.2025.
//


import XCTest

final class CharacterListViewUITests: XCTestCase {
    func testErrorViewIsShown() {
        let app = XCUIApplication()
        app.launchArguments.append("--UITest_ShowError")
        app.launch()

        XCTAssertTrue(app.staticTexts["Oops! Something went wrong."].exists)
        XCTAssertTrue(app.buttons["Retry"].exists)
    }

    func testCharacterListLoadsSuccessfully() {
        let app = XCUIApplication()
        app.launchArguments.append("--UITest_SuccessState")
        app.launch()

        let firstCharacter = app.scrollViews.firstMatch.staticTexts["Test"]
        XCTAssertTrue(firstCharacter.waitForExistence(timeout: 2))
        XCTAssertFalse(app.staticTexts["Oops! Something went wrong."].exists)
        XCTAssertTrue(app.staticTexts["Human"].exists)

    }
}
