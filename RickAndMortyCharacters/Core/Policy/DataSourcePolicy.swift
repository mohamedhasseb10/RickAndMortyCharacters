//
//  DataSourcePolicy.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

// MARK: - Data Source Policy
enum DataSourcePolicy {
    /// Always fetch from remote and update local storage
    case remoteOnly
    /// Only fetch from local storage
    case localOnly
    /// Try remote first, fallback to local if remote fails
    case remoteWithLocalFallback
    /// Try local first, fetch from remote if local is empty or expired
    case localWithRemoteRefresh
    
    /// Default policy for the application
    static var `default`: DataSourcePolicy {
        return .localWithRemoteRefresh
    }
}
