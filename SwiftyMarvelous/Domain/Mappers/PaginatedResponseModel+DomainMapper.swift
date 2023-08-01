//
//  PaginatedResponseModel+DomainMapper.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//

import Foundation

extension PaginatedResponseModel {
    
    typealias EntityType = PaginatedResponse
    
    func toDomain<T>(dataType: T.Type) -> PaginatedResponse<T> {
        return PaginatedResponse<T>(offset: offset,
                                    limit: limit,
                                    total: total,
                                    count: count,
                                    results: results?.compactMap({
            ($0 as? any DomainMapper)?.toDomain() as? T
        })
        )
    }
}
