//
//  FetchLibrary.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import Foundation

// Fetch library json file
class FetchLibrary: ObservableObject {
    
    @Published var list = [LibraryModel]()
    @Published var exerciseOfTheDay = UserDefaults.standard.string(forKey: UserDefaultsUtils().exerciseOfTheDayKey)
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        if let url = URL(string: "https://walmin.com/exercisehub/resources/library.json"){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([LibraryModel].self, from: data)
                        DispatchQueue.main.async {
                            self.list = decodedData
                            self.exerciseOfTheDay = self.userDefaults.string(forKey: UserDefaultsUtils().exerciseOfTheDayKey)
                            
                            // Add new exercise of the day if new day
                            if self.userDefaults.bool(forKey: UserDefaultsUtils().updateExerciseOfTheDayKey) {
                                let item = Int.random(in: 0..<self.list.count)
                                
                                self.exerciseOfTheDay = self.list[item].name
                                self.userDefaults.set(self.list[item].name, forKey: UserDefaultsUtils().exerciseOfTheDayKey)
                                
                                self.userDefaults.set(false, forKey: UserDefaultsUtils().updateExerciseOfTheDayKey)
                                
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
