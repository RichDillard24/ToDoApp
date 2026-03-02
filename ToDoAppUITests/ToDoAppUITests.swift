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
    
    
    func testNavigationToTaskGroups() {
        let app = XCUIApplication()
        app.launch()
        
        let professorCard = app.buttons["ProfileCard_Professor"]
        XCTAssertTrue(professorCard.exists, "The Professor car should be visible")
        professorCard.tap()
        
        let homeGroup = app.buttons["TaskGroups_Home"]
        XCTAssertTrue(homeGroup.waitForExistence(timeout: 2), "The home group should be visible")
        homeGroup.tap()
        
        let detailTitle = app.navigationBars["Home"]
        XCTAssertTrue(detailTitle.exists, "The navigation bar title should display the name of thr group")
        
    }
    
    func testTaskLifecycle_AddCompleteAndDelete() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["ProfileCard_Professor"].tap()
        app.buttons["TaskGroups_Home"].tap()
        
        let addTaskButton = app.buttons["AddTaskButton"]
        XCTAssertTrue(addTaskButton.exists)
        addTaskButton.tap()
        
        let allTextFields = app.textFields
        let lastTaskField = allTextFields.element(boundBy : allTextFields.count - 1)
        lastTaskField.tap()
        lastTaskField.typeText("Test Task")
        app.keyboards.buttons["Return"].tap()
        
//        let taskToggle = app.images.matching(identifier: "TaskToggle").firstMatch
//        XCTAssertTrue(taskToggle.exists)
//        taskToggle.tap()
//        
        lastTaskField.swipeLeft()
        app.buttons["Delete"].tap()
        
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == false"), object: lastTaskField )
        let result = XCTWaiter().wait(for: [expectation], timeout: 4)
        XCTAssertEqual(result, .completed, "The task should have been deleted")
    }
}
