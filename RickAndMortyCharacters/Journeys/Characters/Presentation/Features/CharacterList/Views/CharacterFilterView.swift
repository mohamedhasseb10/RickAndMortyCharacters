//
//  CharacterFilterView.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 01/08/2025.
//

import SwiftUI

struct CharacterFilterView<ViewModel: CharacterListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    private let statuses = characterStatus.allCases
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(statuses, id: \.self) { status in
                filterButton(for: status)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

private extension CharacterFilterView {
    func filterButton(for status: characterStatus) -> some View {
        Button(action: { viewModel.handleFilterTap(status) }) {
            Text(status.displayName)
                .font(.system(size: 14, weight: .semibold))
                .padding(.all, 8)
                .background(background(for: status))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.borderColor, lineWidth: 1)
                )
                .foregroundColor(Color.primaryColor)
        }
    }
    
    func background(for status: characterStatus) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(viewModel.isSelected(status) ? Color.borderColor : Color.clear)
    }
}

#Preview {
    let viewModel = CharacterListViewModel()
    CharacterFilterView(viewModel: viewModel)
}


enum characterStatus: String, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
    
    var displayName: String {
        switch self {
        case .alive:
            return "Alive"
        case .dead:
            return "Dead"
        case .unknown:
            return "Unknown"
        }
    }
}
