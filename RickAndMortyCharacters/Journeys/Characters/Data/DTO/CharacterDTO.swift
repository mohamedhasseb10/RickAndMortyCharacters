//
//  CharacterDTO.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation


struct CharacterResponseDTO: Decodable {
    struct Info: Decodable { let count: Int; let pages: Int; let next: String? }
    let info: Info
    let results: [CharacterDTO]
}

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: LocationDTO

    struct LocationDTO: Decodable {
        let name: String
    }

    func toDomain() -> CharacterItem {
        CharacterItem(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            image: image,
            location: location.name
        )
    }
}
