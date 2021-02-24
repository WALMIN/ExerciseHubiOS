//
//  ExerciseModel.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-24.
//

import Foundation

struct ExerciseModel: Codable, Identifiable {
    let id: String
    let name: String
    let exerciseDo: String
}
