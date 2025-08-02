//
//  MockGetCharactersUseCase.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 02/08/2025.
//

import Foundation
@testable import RickAndMortyCharacters

class MockGetCharactersUseCase: GetCharactersUseCase {
    var executeCalled = false
    var result: [CharacterItem] = []
    var error: Error?
    
    func execute(page: Int, status: String?, policy: DataSourcePolicy?) async throws -> [CharacterItem] {
        executeCalled = true
        if let error = error { throw error }
        return result
    }
}
