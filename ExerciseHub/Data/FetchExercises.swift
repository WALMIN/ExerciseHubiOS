//
//  FetchExercises.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-24.
//

import Foundation

class FetchExercises: ObservableObject {
    
    @Published var list = [ExerciseModel]()
    
    init(id: String) {
        if let url = URL(string: "https://www.walmin.com/exercisehub/resources/workouts/default/d_\(id).json"){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([ExerciseModel].self, from: data)
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
