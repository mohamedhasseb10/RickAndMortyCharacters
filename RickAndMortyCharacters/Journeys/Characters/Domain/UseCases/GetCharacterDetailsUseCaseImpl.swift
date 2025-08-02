//
//  GetCharacterDetailsUseCaseImpl.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

// MARK: - Get Character Details Use Case Implementation
class GetCharacterDetailsUseCaseImpl: GetCharacterDetailsUseCase {

    private let repository: CharacterRepository
    private let cachePolicy: CachePolicyProtocol

    init(
        repository: CharacterRepository,
        cachePolicy: CachePolicyProtocol = DefaultCachePolicy()
    ) {
        self.repository = repository
        self.cachePolicy = cachePolicy
    }

    func execute(
        id: Int,
        policy: DataSourcePolicy? = nil
    ) async throws -> CharacterItem {
        do {
            _ = await determineEffectivePolicy()
            return try await repository.getCharacterDetails(id: id)
        } catch {
            throw transformError(error)
        }
    }

    private func determineEffectivePolicy() async -> DataSourcePolicy {
        // Could check local data, for now default to remote
        return .remoteWithLocalFallback
    }

    private func transformError(_ error: Error) -> CoreError {
        if let coreError = error as? CoreError {
            return coreError
        }
        return .repositoryError(error.localizedDescription)
    }
}

extension GetCharacterDetailsUseCaseImpl {
    static func create() -> GetCharacterDetailsUseCaseImpl {
        return GetCharacterDetailsUseCaseImpl(repository: CharacterRepositoryImpl.create())
    }
}
