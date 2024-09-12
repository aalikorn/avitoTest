//
//  UnsplashAPIService.swift
//  avitoTest
//
//  Created by Даша Николаева on 07.09.2024.
//

import Foundation

class UnsplashAPIService {
    static let shared = UnsplashAPIService()
    
    func search(query: String? = nil, complition: @escaping (Result<[MediaItem], Error>) -> Void) {
        let ACCESS_KEY = APIKey
        
        var url: URL
        
        if let query = query {
            guard let urlStr = URL(string: "https://api.unsplash.com/search/photos?query=\(query)&per_page=30&client_id=\(ACCESS_KEY)") else {
                print("error in producing url")
                return
            }
            url = urlStr
        } else {
            guard let urlStr = URL(string: "https://api.unsplash.com/photos/random?count=30&client_id=\(ACCESS_KEY)") else {
                print("error in producing url")
                return
            }
            url = urlStr
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print(url)
            if let data = data {
                do {
                    if query != nil {
                        let result = try JSONDecoder().decode(SearchResult.self, from: data)
                        DispatchQueue.main.async {
                            complition(.success(result.results))
                        }
                    } else {
                        let result = try JSONDecoder().decode([MediaItem].self, from: data)
                        DispatchQueue.main.async {
                            complition(.success(result))
                        }
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
