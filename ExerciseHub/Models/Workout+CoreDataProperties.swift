//
//  Workout+CoreDataProperties.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-16.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var exercises: NSSet?

    public var exercisesArray: [Exercise] {
        let set = exercises as? Set<Exercise> ?? []
        
        return set.sorted {
            $0.timestamp! < $1.timestamp!
            
        }
        
    }
    
}

// MARK: Generated accessors for exercises
extension Workout {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Workout : Identifiable {

}
