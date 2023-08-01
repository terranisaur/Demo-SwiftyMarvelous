//
//  HomeView.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/17/23.
//

import Foundation
import SwiftUI

public struct HomeView<T: View>: View {
    
    @ObservedObject
    var viewModel: HomeViewModel
    
    var destination: (Character) -> T
    
    public init(viewModel: HomeViewModel, destination: @escaping (Character) -> T) {
        self.viewModel = viewModel
        self.destination = destination
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                BaseStateView(
                    viewModel: viewModel,
                    successView: homeView,
                    emptyView: BaseStateDefaultEmptyView(),
                    createErrorView: { errorMessage in
                        BaseStateDefaultErrorView(errorMessage: errorMessage)
                    },
                    loadingView: BaseStateDefaultLoadingView()
                )
            }
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
    
    var homeView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.characters) { item in
                    NavigationLink(
                        destination: destination(item)) {
                            CharacterView(character: item)
                                .task {
                                    await viewModel.loadMoreCharactersIfNeeded(currentItem: item)
                                }
                        }
                }
            }
        }
        .padding()
        .navigationTitle("SwiftyMarvel")
        .searchable(text: $viewModel.searchText, prompt: "Type character name...")
        .onChange(of: viewModel.debouncedSearchText, perform: { _ in
            Task {
                await viewModel.searchCharacters()
            }
        })
    }
}
