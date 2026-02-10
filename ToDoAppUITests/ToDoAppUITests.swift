//
//  ToDoAppUITests.swift
//  ToDoAppUITests
//
//  Created by Richard Dillard on 1/24/26.
//

import XCTest

final class ToDoAppUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchInEnglish() {
        app.launchArguments = ["-AppleLanguages", "(en)"]
        app.launch()
        
        let header = app.staticTexts["Who is working today?"]
        XCTAssertTrue(header.exists, "English header is missing")
        
    }
    func testLaunchInSpanish() {
        app.launchArguments = ["-AppleLanguages", "(es)"]
        app.launch()
        
        let header = app.staticTexts["¿Quién está trabajando hoy?"]
        XCTAssertTrue(header.exists, "Spanish header is missing")
    }
    func testCreateNewGroup() {
        app.launch()
        let Profile_picker = app.buttons["Profile_pickerRich Dillard"]
        XCTAssertTrue(Profile_picker.exists)
        Profile_picker.tap()
        
        let Add_Group = app.buttons["Add_Group"]
        XCTAssertTrue(Add_Group.exists)
        Add_Group.tap()
        
        let nameField = app.textFields["groupName"]
        XCTAssertTrue(nameField.exists)
        nameField.tap()
        nameField.typeText("Test Group")
        
        let iconButton = app.images["icon_house.fill"]
        iconButton.tap()
        
        app.buttons["save"].tap()
        
        XCTAssertTrue(app.buttons["Task_Groups"].exists)
    }
}
