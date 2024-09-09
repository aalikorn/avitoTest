//
//  UnsplashModel.swift
//  avitoTest
//
//  Created by Даша Николаева on 07.09.2024.
//

import Foundation

struct SearchResult: Codable {
    let results: [MediaItem]
}

struct MediaItem: Codable {
    let id: String
    let description: String?
    let urls: Urls
    let user: User
}

struct Urls: Codable {
    let small: String
    let full: String
}

struct User: Codable {
    let username: String
}

