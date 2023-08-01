//
//  ContentView.swift
//  SwiftyMarvelous
//
//  Created by Alex Thurston on 7/18/23.
//

import SwiftUI

struct ContentView: View {
    
    var container: Container
    
    var body: some View {
        HomeView(viewModel: container.homeViewModel, destination: { character in
            CharacterProfileView(
                character: character,
                viewModel: CharacterProfileViewModel(fetchComics: container.createComicsFetcher())
            )
        })
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(container: Container())
    }
}
