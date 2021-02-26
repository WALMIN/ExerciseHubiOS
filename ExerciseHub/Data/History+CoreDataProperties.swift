//
//  History+CoreDataProperties.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-25.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    
    public var wrappedTitle: String {
        title ?? "?"
        
    }
    
}

extension History : Identifiable {

}
