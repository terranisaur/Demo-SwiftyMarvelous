//
//  Container.swift
//  SwiftyMarvelous
//
//  Created by Alex Thurston on 7/31/23.
//

import Foundation

@MainActor
class Container: ObservableObject {
    
    private let store: NetworkStore
    
    init(store: NetworkStore = .urlSession) {
        self.store = store
    }
    
    lazy var homeViewModel = HomeViewModel(
        fetchCharacters: self.createCharactersFetcher(),
        limit: NetworkFetcher.APIConstants.defaultLimit
    )
    
    // MARK: Fetchers
    func createCharactersFetcher() -> (GetCharactersParams) async -> Result<PaginatedResponse<Character>, AppError> {
        let fetcher = NetworkFetcher.characterFetcher(store: store)
        return { params in
            let data = NetworkFetcher.CharacterFetchData(offset: params.offset, searchKey: params.searchKey)
            let result = await fetcher(data)
            return result.map { $0.data.toDomain(dataType: Character.self) }
        }
    }
    
    func createComicsFetcher() -> (GetComicsParams) async -> Result<PaginatedResponse<Comic>, AppError> {
        let fetcher = NetworkFetcher.comicFetcher(store: store)
        return { params in
            let data = NetworkFetcher.ComicsFetchData(offset: params.offset, characterID: params.characterID)
            let result = await fetcher(data)
            return result.map { $0.data.toDomain(dataType: Comic.self) }
        }
    }
}
