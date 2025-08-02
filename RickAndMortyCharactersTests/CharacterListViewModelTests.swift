//
//  Test.swift
//  RickAndMortyCharactersTests
//
//  Created by Mohamed Abdelhaseeb on 02/08/2025.
//
import Foundation
import Testing
@testable import RickAndMortyCharacters

@MainActor
struct CharacterListViewModelTests {
    
    @Test
    func testLoadInitialSuccess() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.result = [
            CharacterItem(id: 1, name: "Rick", status: "Alive",
                          species: "Human", gender: "Male",
                          image: "", location: "Earth")
        ]
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)
        await viewModel.loadInitial()
        #expect(mockUseCase.executeCalled)
        #expect(viewModel.characters.count == 1)
        #expect(viewModel.characters.first?.name == "Rick")
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func testLoadInitialFailure() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.error = NSError(domain: "Test", code: 1)
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)
        await viewModel.loadInitial()
        #expect(mockUseCase.executeCalled)
        #expect(viewModel.characters.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }

    @Test
    func testLoadMoreAppendsCharacters() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        mockUseCase.result = [
            CharacterItem(id: 1, name: "Rick", status: "Alive",
                          species: "Human", gender: "Male",
                          image: "", location: "Earth")
        ]
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)
        await viewModel.loadInitial()
        await viewModel.loadMore()
        #expect(viewModel.characters.count > 1)
    }

    @Test
    func testSetStatusChangesSelection() async throws {
        let mockUseCase = MockGetCharactersUseCase()
        let viewModel = CharacterListViewModel(getCharactersUseCase: mockUseCase)
        await viewModel.setStatus(.alive)
        #expect(viewModel.selectedStatus == .alive)
    }
}
