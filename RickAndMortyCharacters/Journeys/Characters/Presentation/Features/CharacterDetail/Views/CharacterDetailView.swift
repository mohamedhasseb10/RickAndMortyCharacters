//
//  CharacterDetailView.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 01/08/2025.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterItem
    let onBack: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            headerImage
            content
            backButton
        }
        .ignoresSafeArea()
    }
}

// MARK: - Subviews
private extension CharacterDetailView {
    var headerImage: some View {
        AsyncImage(url: URL(string: character.image)) { image in
            image.resizable()
        } placeholder: {
            Color.gray
        }
        .aspectRatio(contentMode: .fill)
        .frame(height: 320)
        .frame(maxWidth: .infinity)
        .clipped()
        .cornerRadius(35, corners: [.allCorners])
    }

    var content: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 320)
            VStack(alignment: .leading, spacing: 26) {
                titleSection
                locationSection
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            Spacer()
        }
    }

    var titleSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color.primaryColor)

                HStack(spacing: 8) {
                    Text(character.species)
                    Text("•")
                    Text(character.gender)
                }
                .font(.system(size: 18))
                .foregroundColor(Color.secondaryColor)
            }
            Spacer()
            Text(character.status)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.primaryColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
                .background(Color.statusColor)
                .clipShape(Capsule())
                .padding(.top, 4)
        }
    }

    var locationSection: some View {
        HStack {
            Text("Location :")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color.primaryColor)
            Text(character.location)
                .font(.system(size: 18))
                .foregroundColor(Color.secondaryColor)
        }
    }

    var backButton: some View {
        Button(action: onBack) {
            Image(systemName: "arrow.left")
                .foregroundColor(Color.primaryColor)
                .frame(width: 44, height: 44)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 2)
        }
        .padding(.leading, 16)
        .padding(.top, 60)
    }
}


#Preview {
    CharacterDetailView(character: CharacterItem.fakeObject()) {
        // Action for back button
    }
}
