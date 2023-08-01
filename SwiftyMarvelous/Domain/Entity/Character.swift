//
//  Character.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//

import Foundation

public struct Character: Identifiable {
    
    public let id: Int?
    public let name, description: String?
    public let modified: String?
    public let thumbnail: Thumbnail?
    
    // MARK: Computed Properties
    public var imageURL: URL? {
        guard let path = thumbnail?.path, let ext = thumbnail?.thumbnailExtension else { return nil }
        return URL(string: "\(path).\(ext)")
    }
    
    public var safeDescription: String {
        return description != nil && description?.isEmpty != true ?
        description! : "No Description Found"
    }
    
    public init(id: Int?,
         name: String?,
         description: String? = nil,
         modified: String? = nil,
         thumbnail: Thumbnail? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
    }
    
    static func dummyCharacter() -> Character {
        return Character(id: 1016181,
                         name: "Spider Man",
                         // swiftlint:disable line_length
                         description: """
                         Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Iaculis nunc sed augue lacus viverra vitae congue. Arcu cursus euismod quis viverra nibh cras. Sapien eget mi proin sed. Interdum consectetur libero id faucibus nisl. Sed enim ut sem viverra aliquet eget sit amet. Elit sed vulputate mi sit. Libero volutpat sed cras ornare arcu dui. Orci a scelerisque purus semper eget duis at tellus. Ultrices sagittis orci a scelerisque. Tortor posuere ac ut consequat semper viverra nam libero. Tellus in hac habitasse platea. Nisl suscipit adipiscing bibendum est. Dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. A erat nam at lectus urna duis convallis convallis. Enim neque volutpat ac tincidunt vitae semper quis. Facilisi nullam vehicula ipsum a arcu cursus. Sed augue lacus viverra vitae congue eu consequat ac felis.
                         """,
                         // swiftlint:enable line_length
                         modified: "",
                         thumbnail: Thumbnail(
                            path: "http://i.annihil.us/u/prod/marvel/i/mg/9/03/5239b59f49020",
                            thumbnailExtension: "jpg"
                         ))
    }

}

// MARK: - Character + Equatable
extension Character: Equatable {
    
    public static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}
