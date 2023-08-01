//
//  NetworkFetcher.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/17/23.
//

import Foundation

public enum NetworkFetcher { }
    
// MARK: - Helpers
extension NetworkFetcher {
    
    static func modelFetcher<T, U: Codable>(
        createURLRequest: @escaping (T) throws -> URLRequest,
        store: NetworkStore = .urlSession
    ) -> (T) async -> Result<BaseResponseModel<PaginatedResponseModel<U>>, AppError> {
        let networkFetcher = self.networkFetcher(store: store)
        let mapper: (Data) throws -> BaseResponseModel<PaginatedResponseModel<U>> = jsonMapper()
        
        let fetcher = self.fetcher(
            createURLRequest: createURLRequest,
            fetch: { request -> (Data, URLResponse) in
                try await networkFetcher(request)
            }, mapper: { data -> BaseResponseModel<PaginatedResponseModel<U>> in
                try mapper(data)
            })
        
        return { params in
            await fetcher(params)
        }
    }
    
    static func fetcher<T, U>(
        createURLRequest: @escaping (T) throws -> URLRequest,
        fetch: @escaping (URLRequest) async throws -> (Data, URLResponse),
        mapper: @escaping (Data) throws -> U
    ) -> (T) async -> Result<U, AppError> {
        { params in
            do {
                let request = try createURLRequest(params)
                let (data, _) = try await fetch(request)
                let result = try mapper(data)
                return .success(result)
            } catch {
                return .failure(error.toAppError)
            }
        }
    }
    
    static func networkFetcher(
        store: NetworkStore
    ) -> (URLRequest) async throws -> (Data, URLResponse) {
        { request in
            let (data, response) = try await store.fetchData(request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw NetworkError.invalidServerResponse
            }
            
            return (data, response)
        }
    }
    
    static func jsonMapper<T: Decodable>() -> (Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return { data in
            try decoder.decode(T.self, from: data)
        }
    }
}
