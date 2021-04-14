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
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        if let url = URL(string: "https://www.walmin.com/exercisehub/resources/workouts_default.json"){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([WorkoutModel].self, from: data)
                        DispatchQueue.main.async {
                            self.list = decodedData
                            
                            // Add new exercise of the day if new day
                            if self.userDefaults.bool(forKey: UserDefaultsUtils().updateWorkoutOfTheDayKey) {
                                let item = Int.random(in: 0..<self.list.count)
                                
                                self.userDefaults.set(self.list[item].name, forKey: UserDefaultsUtils().workoutOfTheDayKey)
                                self.userDefaults.set(self.list[item].desc, forKey: UserDefaultsUtils().workoutOfTheDayDescKey)
                                self.userDefaults.set(self.list[item].id, forKey: UserDefaultsUtils().workoutOfTheDayIDKey)
                                
                                self.userDefaults.set(false, forKey: UserDefaultsUtils().updateWorkoutOfTheDayKey)
                                
                            }
                            
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
