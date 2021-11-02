//
//  Workout.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

struct Workout {
    let title: String
    let countExercise: Int
    let muscleGroup: [MuscleGroup]
    let system: Bool
    let exercises: [Exercise]?
}
