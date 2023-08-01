//
//  CharacterModel.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//
import Foundation

public struct CharacterModel: Codable {
    public let id: Int?
    public let name, description: String?
    public let modified: String?
    public let thumbnail: ThumbnailModel?
    
    public init(id: Int? = nil,
         name: String? = nil,
         description: String? = nil,
         modified: String? = nil,
         thumbnail: ThumbnailModel? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.thumbnail = thumbnail
    }
}

public struct ThumbnailModel: Codable {
    public let path: String?
    public let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
