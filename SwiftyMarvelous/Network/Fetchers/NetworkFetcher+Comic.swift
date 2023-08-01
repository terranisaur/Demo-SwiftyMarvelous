//
//  NetworkFetcher+Comic.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/18/23.
//

import Foundation

public extension NetworkFetcher {
    
    struct ComicsFetchData {
        let offset: Int
        let characterID: Int
    }
    
    static func comicFetcher(
        store: NetworkStore = .urlSession
    ) -> (ComicsFetchData) async -> Result<BaseResponseModel<PaginatedResponseModel<ComicModel>>, AppError> {
        let createURLRequest = { (params: ComicsFetchData) -> URLRequest in
            let urlParams = ["offset": "\(params.offset)", "limit": "\(APIConstants.defaultLimit)"]
            return try createRequest(
                requestType: .GET,
                path: "/v1/public/characters/\(params.characterID)/comics",
                urlParams: urlParams
            )
        }
        
        return self.modelFetcher(createURLRequest: createURLRequest)
    }
}
