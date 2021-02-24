//
//  WorkoutModel.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-23.
//

import Foundation

struct WorkoutModel: Codable, Identifiable {
    let id: String
    let name: String
    let desc: String
}
