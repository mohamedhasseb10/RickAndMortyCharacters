//
//  CharacterDetailViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

@MainActor
protocol CharacterDetailViewModelProtocol: AnyObject {
    var character: CharacterItem? { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get set }
    var getCharacterDetailsUseCase: GetCharacterDetailsUseCase { get }
    func load(id: Int) async
}


@MainActor
class CharacterDetailViewModel: ObservableObject, CharacterDetailViewModelProtocol  {
    @Published var character: CharacterItem?
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    let getCharacterDetailsUseCase: GetCharacterDetailsUseCase

    init(
        getCharacterDetailsUseCase:
        GetCharacterDetailsUseCase = GetCharacterDetailsUseCaseImpl.create()
    ) {
        self.getCharacterDetailsUseCase = getCharacterDetailsUseCase
    }

    func load(id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            character = try await getCharacterDetailsUseCase.execute(
                id: id, policy: .remoteWithLocalFallback)
        } catch {
            errorMessage = "Error loading: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
