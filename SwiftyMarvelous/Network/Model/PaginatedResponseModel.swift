//
//  PaginatedResponseModel.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//

import Foundation

public struct PaginatedResponseModel<T>: Codable  where T: Codable {
    public let offset, limit, total, count: Int?
    public let results: [T]?
}
