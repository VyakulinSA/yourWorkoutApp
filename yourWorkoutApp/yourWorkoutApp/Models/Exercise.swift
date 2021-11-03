//
//  Exercise.swift
//  yourWorkoutApp
//
//  Created by Вякулин Сергей on 01.11.2021.
//

import Foundation

enum MuscleGroup: String, CaseIterable{
    case wholeBody = "Whole Body"
    case shoulders = "Shoulders"
    case biceps = "Biceps"
    case chest = "Chest"
    case triceps = "Triceps"
    case back = "Back"
    case abs = "Abs"
    case legs = "Legs"
}

struct Exercise {
    let title: String
    let muscleGroup: MuscleGroup
    let description: String
    let startImage: Data?
    let endImage: Data?
    let workout: Workout?
}
