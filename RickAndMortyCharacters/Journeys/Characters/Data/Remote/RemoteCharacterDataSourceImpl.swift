//
//  CharacterRemoteDataSource.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//


import Foundation


// MARK: - Remote Data Source Implementation
class RemoteCharacterDataSourceImpl: RemoteCharacterDataSource {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
    }

    func fetchCharacters(page: Int, status: String?) async throws -> [CharacterDTO] {
        let response: CharacterResponseDTO = try await networkClient.request(
            APIEndpoints.characters(page: page, status: status)
        )
        return response.results
    }

    func fetchCharacterDetails(id: Int) async throws -> CharacterDTO {
        try await networkClient.request(APIEndpoints.characterDetails(id: id))
    }
}

