//
//  CharacterProfileViewModel.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/17/23.
//

import Foundation

@MainActor
public final class CharacterProfileViewModel: ViewModel {
    
    // MARK: Dependencies
    private let fetchComics: (GetComicsParams) async -> Result<PaginatedResponse<Comic>, AppError>
    
    // MARK: Properties
    private var currentOffset = 0
    
    // MARK: Observable Properties
    @Published var comics: [Comic] = []
    
    public init(fetchComics: @escaping (GetComicsParams) async -> Result<PaginatedResponse<Comic>, AppError>) {
        self.fetchComics = fetchComics
    }
}

// MARK: - Actions
extension CharacterProfileViewModel {
    
    func loadComics(forCharacter id: Int) async {
        state = .loading
        let result = await fetchComics(.init(offset: 0, characterID: id))
        switch result {
        case .success(let data):
            comics.append(contentsOf: data.results ?? [])
            state = .success
        case .failure(let err):
            state = .error(err.localizedDescription)
        }
    }
}
