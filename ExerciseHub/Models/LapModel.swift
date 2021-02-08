//
//  LapModel.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-08.
//

import Foundation

struct LapModel: Identifiable {
    let id = UUID()
    let position: Int
    let time: Double
}
