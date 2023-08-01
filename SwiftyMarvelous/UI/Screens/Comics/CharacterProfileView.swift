//
//  CharacterProfileView.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/17/23.
//

import SwiftUI
import Kingfisher

public struct CharacterProfileView: View {
    
    // MARK: Properties
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let character: Character
    @ObservedObject var viewModel: CharacterProfileViewModel
    
    public init(character: Character, viewModel: CharacterProfileViewModel) {
        self.character = character
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                coverImageView
                contentView
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.hidden, for: .navigationBar)
        .ignoresSafeArea()
        .onAppear {
            Task {
                await viewModel.loadComics(forCharacter: character.id ?? 0)
            }
        }
    }
    
    // MARK: View Sections
    private var coverImageView: some View {
        CachedImageView(character.imageURL)
            .aspectRatio(contentMode: .fill)
            .frame(
                height: 350,
                alignment: .center
            )
            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
    }
    
    private var contentView: some View {
        LazyVStack(alignment: .leading) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .padding([.top], 60)
            }
            Spacer()
                .frame(height: 280)
            Text(character.name ?? "")
                .font(.system(.largeTitle, weight: .bold))
                .padding([.bottom], 10)
            
            Text(character.safeDescription)
                .font(.body)
                .padding([.bottom], 10)
            
            comicsSection
            
        }
        .padding([.leading, .bottom], 20)
    }
    
    private var comicsSection: some View {
        BaseStateView(
            viewModel: viewModel,
            successView: successView,
            emptyView: BaseStateDefaultEmptyView(),
            createErrorView: { errorMessage in
                BaseStateDefaultErrorView(errorMessage: errorMessage)
            },
            loadingView: BaseStateDefaultLoadingView()
        )
    }
    
    private var successView: some View {
        VStack(alignment: .leading) {
            Text("Comics")
                .font(.system(.title2, weight: .bold))
                .padding([.bottom], 5)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.comics) { item in
                        ComicItemView(comic: item)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct CharacterProfileView2_Previews: PreviewProvider {
    static var previews: some View {
        CharacterProfileView(
            character: Character.dummyCharacter(),
            viewModel: CharacterProfileViewModel(fetchComics: { _ in
                .success(.init(offset: 0, limit: 0, total: 0, count: 0, results: []))
            })
        )
    }
}
