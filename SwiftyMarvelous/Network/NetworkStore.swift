//
//  NetworkStore.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/17/23.
//

import Foundation

public class NetworkStore {
    
    let fetchData: (URLRequest) async throws -> (Data, URLResponse)
    
    init(fetchData: @escaping (URLRequest) async throws -> (Data, URLResponse)) {
        self.fetchData = fetchData
    }
}

public extension NetworkStore {
    
    static var urlSession: NetworkStore {
        .init { request in
            try await URLSession.shared.data(for: request)
        }
    }
}
