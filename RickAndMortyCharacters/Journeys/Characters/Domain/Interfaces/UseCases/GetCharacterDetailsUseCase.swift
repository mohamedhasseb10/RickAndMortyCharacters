//
//  GetCharacterDetailsUseCase.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

// MARK: - Get Character Details Use Case Protocol
protocol GetCharacterDetailsUseCase {
    /// Fetches details of a character by ID
    /// - Parameters:
    ///   - id: The character ID
    ///   - policy: Optional data source policy
    /// - Returns: A Character domain model
    /// - Throws: CoreError if the operation fails
    func execute(
        id: Int,
        policy: DataSourcePolicy?
    ) async throws -> CharacterItem
}
