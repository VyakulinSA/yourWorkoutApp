//
//  ExerciseCD+CoreDataProperties.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 07.11.2021.
//
//

import Foundation
import CoreData


extension ExerciseCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseCD> {
        return NSFetchRequest<ExerciseCD>(entityName: "ExerciseCD")
    }

    @NSManaged public var title: String
    @NSManaged public var muscleGroup: String
    @NSManaged public var descriptionText: String
    @NSManaged public var startImageName: String?
    @NSManaged public var endImageName: String?
    @NSManaged public var id: UUID
    @NSManaged public var workoutCD: NSSet?
    @NSManaged public var createdDate: Date

}

// MARK: Generated accessors for workoutCD
extension ExerciseCD {

    @objc(addWorkoutCDObject:)
    @NSManaged public func addToWorkoutCD(_ value: WorkoutCD)

    @objc(removeWorkoutCDObject:)
    @NSManaged public func removeFromWorkoutCD(_ value: WorkoutCD)

    @objc(addWorkoutCD:)
    @NSManaged public func addToWorkoutCD(_ values: NSSet)

    @objc(removeWorkoutCD:)
    @NSManaged public func removeFromWorkoutCD(_ values: NSSet)

}

extension ExerciseCD : Identifiable {

}
