//
//  CharacterRepository.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

class CharacterRepositoryImpl: CharacterRepository {
    private let remoteDataSource: RemoteCharacterDataSource

    init(remoteDataSource: RemoteCharacterDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getCharacters(page: Int, status: String?) async throws -> [CharacterItem] {
        let dtos = try await remoteDataSource.fetchCharacters(page: page, status: status)
        return dtos.map { $0.toDomain() }
    }

    func getCharacterDetails(id: Int) async throws -> CharacterItem {
        let dto = try await remoteDataSource.fetchCharacterDetails(id: id)
        return dto.toDomain()
    }
}

extension CharacterRepositoryImpl {
    static func create() -> CharacterRepositoryImpl {
        return CharacterRepositoryImpl(remoteDataSource: RemoteCharacterDataSourceImpl())
    }
}
