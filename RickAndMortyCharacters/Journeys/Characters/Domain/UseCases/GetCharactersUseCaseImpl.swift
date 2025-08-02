//
//  GetCharactersUseCaseImpl.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

// MARK: - Get Characters Use Case Implementation
class GetCharactersUseCaseImpl: GetCharactersUseCase {

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
        page: Int,
        status: String?,
        policy: DataSourcePolicy? = nil
    ) async throws -> [CharacterItem] {
        do {
            _ = await determineEffectivePolicy()
            // policy can be used to decide between local/remote data.
            // For simplicity, currently we always fetch remote.
            return try await repository.getCharacters(
                page: page,
                status: status
            )
        } catch {
            throw transformError(error)
        }
    }

    private func determineEffectivePolicy() async -> DataSourcePolicy {
        // Example logic: Could check if repository has cached data
        return .remoteWithLocalFallback
    }

    private func transformError(_ error: Error) -> CoreError {
        if let coreError = error as? CoreError {
            return coreError
        }
        return .repositoryError(error.localizedDescription)
    }
}

extension GetCharactersUseCaseImpl {
    static func create() -> GetCharactersUseCaseImpl {
        return GetCharactersUseCaseImpl(repository: CharacterRepositoryImpl.create())
    }
}
