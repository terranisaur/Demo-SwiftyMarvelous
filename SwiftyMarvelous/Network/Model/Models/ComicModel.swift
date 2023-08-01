//
//  ComicModel.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 14/07/2023.
//

import Foundation

public struct ComicModel: Codable {
    public let id: Int?
    public let title, description: String?
    public let modified: String?
    public let isbn, upc, diamondCode, ean: String?
    public let issn, format: String?
    public let thumbnail: ThumbnailModel?
}
