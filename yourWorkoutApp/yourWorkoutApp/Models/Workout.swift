//
//  Workout.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

protocol WorkoutModelProtocol {
    var title: String { get set }
    var muscleGroups: [MuscleGroup] { get set }
    var system: Bool { get set }
    var exercises: [ExerciseModelProtocol]? { get set }
    var id: UUID { get set }
}

struct WorkoutModel: WorkoutModelProtocol {
    var title: String
    var muscleGroups: [MuscleGroup]
    var system: Bool
    var exercises: [ExerciseModelProtocol]?
    var id: UUID
}
