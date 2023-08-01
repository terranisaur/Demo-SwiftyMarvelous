//
//  PaginatedResponse.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//

import Foundation

public struct PaginatedResponse<T: Equatable>: Equatable{
    public let offset, limit, total, count: Int?
    public let results: [T]?
    
    public static func == (lhs: PaginatedResponse<T>, rhs: PaginatedResponse<T>) -> Bool {
        lhs.offset == rhs.offset &&
            lhs.limit == rhs.limit &&
            lhs.total == rhs.total &&
            lhs.count == rhs.count &&
            lhs.results == rhs.results
    }
}
