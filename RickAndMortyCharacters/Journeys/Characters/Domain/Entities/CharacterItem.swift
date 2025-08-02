//
//  CharacterItem.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

struct CharacterItem {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: String
    
    
    static func fakeObject() -> CharacterItem {
        return CharacterItem(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            gender: "Male",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            location: "Earth (New York City)"
        )
    }
}
