//
//  CharacterRepository.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

protocol CharacterRepository {
    func getCharacters(page: Int, status: String?) async throws -> [CharacterItem]
    func getCharacterDetails(id: Int) async throws -> CharacterItem
}
