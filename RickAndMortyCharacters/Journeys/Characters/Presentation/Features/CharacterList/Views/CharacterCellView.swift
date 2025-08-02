//
//  CharacterCellView.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 31/07/2025.
//

import SwiftUI

struct CharacterCellView: View {
    let character: CharacterItem
    private var imageURL: URL? {
        URL(string: character.image)
    }
    private var nameText: String { character.name }
    private var speciesText: String { character.species }
    var body: some View {
        HStack(alignment: .top) {
            characterImage
            characterInfo
            Spacer()
        }
        .padding(12)
        .frame(height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.borderColor, lineWidth: 0.7)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 12)
    }
}

private extension CharacterCellView {
    var characterImage: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable()
        } placeholder: {
            Color.gray
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    var characterInfo: some View {
        VStack(alignment: .leading) {
            Text(nameText)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.primaryColor)
            Text(speciesText)
                .font(.subheadline)
                .foregroundColor(Color.secondaryColor)
        }
    }
}

#Preview {
    CharacterCellView(
        character: CharacterItem.fakeObject()
    )
}

