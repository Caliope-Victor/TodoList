//
//  Activity+CoreDataProperties.swift
//  TodoList
//
//  Created by Igor Samoel da Silva on 18/07/22.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var name: String?

}

extension Activity : Identifiable {
}
