//
//  ImageViewURL.swift
//  ExerciseHub
//
//  Created by Victor Bergene on 2021-02-01.
//

import Foundation
import SwiftUI

struct ImageViewURL: View {
    
    @ObservedObject var imageLoader: ImageLoader

    init(_ url: String) {
        imageLoader = ImageLoader(url: url)
        
    }

    var body: some View {
          Image(uiImage: UIImage(data: self.imageLoader.data) ?? UIImage())
              .resizable().clipped()
        
    }
    
}

class ImageLoader: ObservableObject {
    
    @Published var data = Data()
    
    init(url: String) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        
        if let data = cache.cachedResponse(for: request)?.data {
            self.data = data
            
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.data = data
                        
                    }
                    
                }
                
            }).resume()
            
        }
        
    }
    
}
