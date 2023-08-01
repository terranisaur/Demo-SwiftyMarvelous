//
//  CharacterView.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 08/07/2023.
//

import SwiftUI
import Kingfisher

struct CharacterView: View {
    
    let character: Character
    
    var body: some View {
        ZStack(alignment: .bottom) {
            CachedImageView(character.imageURL)
                .aspectRatio(2/1, contentMode: .fit)
                .cornerRadius(15)
                .frame(
                    alignment: .center
                )
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .frame(height: 50)
                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                Text(character.name ?? "")
                    .font(.body)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character.dummyCharacter())
    }
}
