//
//  SearchViewModel.swift
//  avitoTest
//
//  Created by Даша Николаева on 08.09.2024.
//

import Foundation

class SearchViewModel {
    var searchResults: Observable<[MediaItem]> = Observable([])
    var error: Observable<Bool> = Observable(false)
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
                self.error.value = false
                self.searchResults.value = mediaItems
            case .failure(let error):
                self.error.value = true
                print("error: \(error)")
            }
        }
    }
    
    private func saveToHistory(_ query: String) {
        var history = searchHistory
        if history.count > 5 { history.removeLast() }
        if let index = history.firstIndex(of: query) {
            history.remove(at: index)
        }
        history.insert(query, at: 0)
        userDefaults.set(history, forKey: "SearchHistory")
    }
}
