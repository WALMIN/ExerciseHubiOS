//
//  Workout+CoreDataProperties.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-18.
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
    @NSManaged public var rounds: NSSet?
    
    public var roundsArray: [Round] {
        let set = rounds as? Set<Round> ?? []
        
        return set.sorted {
            $0.timestamp! < $1.timestamp!
            
        }
        
    }

}

// MARK: Generated accessors for rounds
extension Workout {

    @objc(addRoundsObject:)
    @NSManaged public func addToRounds(_ value: Round)

    @objc(removeRoundsObject:)
    @NSManaged public func removeFromRounds(_ value: Round)

    @objc(addRounds:)
    @NSManaged public func addToRounds(_ values: NSSet)

    @objc(removeRounds:)
    @NSManaged public func removeFromRounds(_ values: NSSet)

}

extension Workout : Identifiable {

}
