//
//  Exercise+CoreDataProperties.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-18.
//
//

import Foundation
import CoreData

extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var exerciseDo: String?
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var round: Round?

    public var wrappedExerciseDo: String {
        exerciseDo ?? "?"
        
    }
    
    public var wrappedName: String {
        name ?? "?"
        
    }
    
}

extension Exercise : Identifiable {

}
