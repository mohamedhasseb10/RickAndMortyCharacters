//
//  CharacterDataSource.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

protocol RemoteCharacterDataSource {
    func fetchCharacters(page: Int, status: String?) async throws -> [CharacterDTO]
    func fetchCharacterDetails(id: Int) async throws -> CharacterDTO
}
