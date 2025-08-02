//
//  GetCharactersUseCase.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

// MARK: - Get Characters Use Case Protocol
protocol GetCharactersUseCase {
    /// Fetches characters with pagination and optional status filter
    /// - Parameters:
    ///   - page: The page number to load
    ///   - status: Filter by character status (Alive, Dead, Unknown)
    ///   - policy: Optional data source policy (defaults to .default)
    /// - Returns: An array of Character domain models
    /// - Throws: CoreError if the operation fails
    func execute(
        page: Int,
        status: String?,
        policy: DataSourcePolicy?
    ) async throws -> [CharacterItem]
}

