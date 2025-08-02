//
//  CoreError.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

// MARK: - Core Error
enum CoreError: LocalizedError, Equatable {
    case repositoryError(String)
    case invalidData
    case storageError(String)
    case networkError(String)
    case dataSourceError(String)
    
    static func == (lhs: CoreError, rhs: CoreError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidData, .invalidData):
            return true
        case let (.repositoryError(lhsMessage), .repositoryError(rhsMessage)),
             let (.storageError(lhsMessage), .storageError(rhsMessage)),
             let (.networkError(lhsMessage), .networkError(rhsMessage)),
             let (.dataSourceError(lhsMessage), .dataSourceError(rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .repositoryError(let message):
            return "Repository Error: \(message)"
        case .invalidData:
            return "Invalid Data Error: The data format is incorrect"
        case .storageError(let message):
            return "Storage Error: \(message)"
        case .networkError(let message):
            return "Network Error: \(message)"
        case .dataSourceError(let message):
            return "Data Source Error: \(message)"
        }
    }
}
