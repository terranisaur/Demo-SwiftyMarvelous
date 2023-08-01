//
//  HomeViewModel.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/17/23.
//

import Foundation

@MainActor
public final class HomeViewModel: ViewModel {
    
    // MARK: Dependencies
    private let fetchCharacters: (GetCharactersParams) async -> Result<PaginatedResponse<Character>, AppError>
    
    // MARK: Properties
    private var limit: Int
    private var currentOffset = 0
    private var totalCount = 0
    private let debounceTime: Int
    
    // MARK: Observable Properties
    @Published var characters: [Character] = []
    @Published var searchText = ""
    @Published var debouncedSearchText = ""
    var isSearching: Bool {
        !debouncedSearchText.isEmpty
    }
    
    public init(
        fetchCharacters: @escaping (GetCharactersParams) async -> Result<PaginatedResponse<Character>, AppError>,
        limit: Int,
        debounceTime: Int = 700
    ) {
        self.fetchCharacters = fetchCharacters
        self.limit = limit
        self.debounceTime = debounceTime
        super.init()
        setupSearchDebouncer()
    }
    
    private func setupSearchDebouncer() {
        $searchText
            .debounce(for: .milliseconds(debounceTime), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchText)
    }
}

// MARK: - Actions
extension HomeViewModel {
    
    func loadCharacters(from offset: Int = 0) async {
        state = .loading
        let params = GetCharactersParams(
            offset: offset,
            searchKey: debouncedSearchText.isEmpty ? nil : debouncedSearchText
        )
        let result = await fetchCharacters(params)
        switch result {
        case .success(let data):
            characters.append(contentsOf: data.results ?? [])
            totalCount = data.total ?? 0
            if characters.isEmpty {
                state = .empty
            } else {
                state = .success
            }
        case .failure(let err):
            state = .error(err.localizedDescription)
        }
    }
    
    func searchCharacters() async {
        currentOffset = 0
        characters = []
        await loadCharacters()
    }
    
    func loadMoreCharactersIfNeeded(currentItem: Character) async {
        guard characters.last?.id == currentItem.id && currentOffset < totalCount else {
            return
        }
        currentOffset += limit
        await loadCharacters(from: currentOffset)
    }
}
