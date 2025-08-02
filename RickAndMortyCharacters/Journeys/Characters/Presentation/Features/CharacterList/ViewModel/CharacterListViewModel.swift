//
//  CharacterListViewModel.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import Foundation

@MainActor
protocol CharacterListViewModelProtocol: ObservableObject {
    var characters: [CharacterItem] { get }
    var isLoading: Bool { get }
    var selectedStatus: characterStatus? { get set }
    var currentPage: Int { get }
    var canLoadMore: Bool { get }
    var errorMessage: String? { get set }
    var getCharactersUseCase: GetCharactersUseCase { get }

    func loadInitial() async
    func loadMore() async
    func setStatus(_ status: characterStatus?) async
    func isSelected(_ status: characterStatus) -> Bool
    func handleFilterTap(_ status: characterStatus)
}


@MainActor
class CharacterListViewModel: ObservableObject, CharacterListViewModelProtocol {
    @Published var characters: [CharacterItem] = []
    @Published var isLoading = false
    @Published var selectedStatus: characterStatus? = nil
    @Published var errorMessage: String? = nil

    let getCharactersUseCase: GetCharactersUseCase
    var currentPage = 1
    var canLoadMore = true

    init(getCharactersUseCase: GetCharactersUseCase = GetCharactersUseCaseImpl.create()) {
        self.getCharactersUseCase = getCharactersUseCase
    }

    func loadInitial() async {
        currentPage = 1
        characters = []
        canLoadMore = true
        await loadMore()
    }

    func loadMore() async {
        guard !isLoading && canLoadMore else { return }
        isLoading = true
        errorMessage = nil
        do {
            let newCharacters = try await getCharactersUseCase.execute(page: currentPage, status: selectedStatus?.displayName, policy: .remoteWithLocalFallback)
            if newCharacters.isEmpty { canLoadMore = false }
            characters.append(contentsOf: newCharacters)
            currentPage += 1
        } catch {
            errorMessage = "Error loading: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func setStatus(_ status: characterStatus?) async {
        selectedStatus = status
        await loadInitial()
    }
    
    func isSelected(_ status: characterStatus) -> Bool {
        selectedStatus == status
    }
    
    func handleFilterTap(_ status: characterStatus) {
        Task {
            if isSelected(status) {
                selectedStatus = nil
            } else {
                selectedStatus = status
            }
            await loadInitial()
        }
    }
}
