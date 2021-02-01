//
//  LibraryModel.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import Foundation

struct LibraryModel: Codable, Identifiable {
    let id = UUID()
    let name: String
}
