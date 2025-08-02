//
//  NetworkConfig.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 30/07/2025.
//

import Foundation

// MARK: - Network Configuration
struct NetworkConfig {
    // Base configurations
    static let baseURL = "https://rickandmortyapi.com/api"
    static let timeout: TimeInterval = 30
    // Default headers
    static let defaultHeaders: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    // API paths
    struct Paths {
        public static let charaters = "/character"
    }
}
