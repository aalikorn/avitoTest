//
//  UnsplashAPIService.swift
//  avitoTest
//
//  Created by Даша Николаева on 07.09.2024.
//

import Foundation

class UnsplashAPIService {
    static let shared = UnsplashAPIService()
    
    func search(query: String, complition: @escaping (Result<[MediaItem], Error>) -> Void) {
        let ACCESS_KEY = "qhH2W-AohX_EzWkeilQTB16kAtsFvIQZZOlomYS_-gI"
        
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&client_id=\(ACCESS_KEY)") else {
            print("error in producing url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print(url)
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    DispatchQueue.main.async {
                        complition(.success(result.results))
                    }
                } catch {
                    complition(.failure(error))
                }
            } else if let error = error {
                complition(.failure(error))
            }
        }
        
        task.resume()
    }
}
