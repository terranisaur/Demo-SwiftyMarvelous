//
//  Params.swift
//  SwiftyMarvelous
//
//  Created by Alex Thurston on 7/26/23.
//

import Foundation

public struct GetCharactersParams {
    public let offset: Int
    public let searchKey: String?
}

public struct GetComicsParams {
    public let offset: Int
    public let characterID: Int
}
