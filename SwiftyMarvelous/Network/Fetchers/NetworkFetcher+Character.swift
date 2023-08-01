//
//  NetworkFetcher+Character.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/18/23.
//

import Foundation

public extension NetworkFetcher {
    
    struct CharacterFetchData {
        let offset: Int
        let searchKey: String?
    }
    
    static func characterFetcher(
        store: NetworkStore = .urlSession
    ) -> (CharacterFetchData) async -> Result<BaseResponseModel<PaginatedResponseModel<CharacterModel>>, AppError> {
        let createURLRequest = { (data: CharacterFetchData) -> URLRequest in
            var urlParams = ["offset": "\(data.offset)", "limit": "\(APIConstants.defaultLimit)"]
            if let searchKey = data.searchKey {
                urlParams["nameStartsWith"] = searchKey
            }
            
            return try createRequest(
                requestType: .GET,
                path: "/v1/public/characters",
                urlParams: urlParams
            )
        }
        
        return self.modelFetcher(createURLRequest: createURLRequest)
    }
}
