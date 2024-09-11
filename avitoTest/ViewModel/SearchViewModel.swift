//
//  SearchViewModel.swift
//  avitoTest
//
//  Created by Даша Николаева on 08.09.2024.
//

import Foundation

class SearchViewModel {
    var searchResults: Observable<[MediaItem]> = Observable([])
    var userDefaults = UserDefaults.standard
    var searchHistory: [String] {
        return userDefaults.array(forKey: "SearchHistory") as? [String] ?? []
    }
    
    func performSearch(_ query: String? = nil) {
        if let query = query {
            saveToHistory(query)
        }
        UnsplashAPIService.shared.search(query: query) { result in
            switch result {
            case .success(let mediaItems):
                self.searchResults.value = mediaItems
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    private func saveToHistory(_ query: String) {
        var history = searchHistory
        history.insert(query, at: 0)
        if history.count > 5 { history.removeLast() }
        userDefaults.set(history, forKey: "SearchHistory")
    }
}
