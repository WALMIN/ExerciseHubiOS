//
//  FetchWorkouts.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-23.
//

import Foundation

// Fetch workouts json file
class FetchWorkouts: ObservableObject {
    
    @Published var list = [WorkoutModel]()
    
    init() {
        if let url = URL(string: "https://www.walmin.com/exercisehub/resources/workouts_default.json"){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([WorkoutModel].self, from: data)
                        DispatchQueue.main.async {
                            self.list = decodedData
                            
                        }
                        
                    } else {
                        print("No data")
                        
                    }
                    
                } catch {
                    print("Error")
                    
                }
                
            }.resume()
            
        }
        
    }
    
}
