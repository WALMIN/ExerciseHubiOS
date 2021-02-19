//
//  Round+CoreDataProperties.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-18.
//
//

import Foundation
import CoreData

extension Round {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Round> {
        return NSFetchRequest<Round>(entityName: "Round")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var cycles: Int16
    @NSManaged public var exercises: NSSet?
    @NSManaged public var workout: Workout?
    
    public var exercisesArray: [Exercise] {
        let set = exercises as? Set<Exercise> ?? []
        
        return set.sorted {
            $0.timestamp! < $1.timestamp!
            
        }
        
    }

}

// MARK: Generated accessors for exercises
extension Round {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Round : Identifiable {

}
