//
//  CachePolicy.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

// MARK: - Cache Policy Protocol
protocol CachePolicyProtocol: Sendable {
    /// Checks if the cached data is still valid
    /// - Parameter lastUpdateTime: The timestamp of the last cache update
    /// - Returns: Boolean indicating if cache is valid
    func isValid(lastUpdateTime: Date) -> Bool
    
    /// Gets the cache expiration time
    var expirationTime: TimeInterval { get }
}
// MARK: - Default Cache Policy
struct DefaultCachePolicy: CachePolicyProtocol {
    /// Default cache expiration time (1 hour)
    let expirationTime: TimeInterval
    
    init(expirationTime: TimeInterval = 3600) {
        self.expirationTime = expirationTime
    }
    
    func isValid(lastUpdateTime: Date) -> Bool {
        let currentTime = Date()
        let timeDifference = currentTime.timeIntervalSince(lastUpdateTime)
        return timeDifference <= expirationTime
    }
}
