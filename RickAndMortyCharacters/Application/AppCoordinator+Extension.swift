//
//  RootCoordinator+Extensio.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//
import Foundation

extension AppCoordinator {
    @MainActor func showCharacterListCoordinator() {
        let coordinator = CharacterListCoordinator(
            navigationController: navigationController)
        coordinator.parent = self
        addChild(coordinator)
        coordinator.start()
    }
    
    @MainActor func showCharacterDetailCoordinator(characterID: Int) {
        let coordinator = CharacterDetailCoordinator(navigationController: navigationController, characterID: characterID)
        coordinator.parent = self
        addChild(coordinator)
        coordinator.start()
    }
}
