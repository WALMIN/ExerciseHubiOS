//
//  Exercise+CoreDataProperties.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-16.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var name: String?
    @NSManaged public var exerciseDo: String?
    @NSManaged public var workout: Workout?

}

extension Exercise : Identifiable {

}
