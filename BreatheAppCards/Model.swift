//
//  Model.swift
//  BreatheAppCards
//
//  Created by Arlind Aliu on 16.10.19.
//  Copyright © 2019 Arlind Aliu. All rights reserved.
//

import Foundation

enum ExerciseType {
    case classic
    case focus
    case calm
}

struct Exercise {
    let type: ExerciseType
    let title: String
    let length: Int
    let description: String
}

extension Exercise {
    static let allExercises: [Exercise] = [
        Exercise(type: .classic, title: "Classic", length: 5, description: "Select this exercise for a classic breathing exercise. Ideal when you need some extra headspace."),
        Exercise(type: .focus, title: "Focus", length: 2, description: "With this excercise you will get your desired foucs back, so you can be even more productive."),
        Exercise(type: .calm, title: "Calm", length: 5, description: "Ideal for a calm down breathe session at the beginning or at the end of the day to relax and clear your mind.")
    ]
}
