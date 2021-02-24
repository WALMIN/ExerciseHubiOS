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
    
    init() {
        if let url = URL(string: "https://walmin.com/exercisehub/resources/library.json"){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([LibraryModel].self, from: data)
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
