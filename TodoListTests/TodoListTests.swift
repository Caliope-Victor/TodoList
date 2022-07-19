//
//  TodoListTests.swift
//  TodoListTests
//
//  Created by Victor Brito on 18/07/22.
//

import XCTest
@testable import TodoList

class TodoListTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchActivities() throws {
        let persistenceController = PersistenceController(inMemory: true)
        let _ = persistenceController.createActivity(name: "Activity 1")
        let activities = persistenceController.fetchActivities()
        XCTAssertEqual(activities.count, 1)
    }
    
    func testCreateActivity() throws {
        let persistenceController = PersistenceController(inMemory: true)
        let activity = persistenceController.createActivity(name: "New Activity")
        XCTAssertEqual(activity.name, persistenceController.fetchActivities().first!.name)
    }
    
    func testDeleteActivity() throws {
        let persistenceController = PersistenceController(inMemory: true)
        let activity = persistenceController.createActivity(name: "Activity Delete")
        XCTAssertEqual(persistenceController.fetchActivities().count, 1)
        persistenceController.delete(object: activity)
        XCTAssertEqual(persistenceController.fetchActivities().count, 0)
    }

}
