//
//  NetworkFetcher+CreateRequest.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 7/17/23.
//

import Foundation
import ArkanaKeys
import CommonCrypto

extension NetworkFetcher {
    
    enum APIConstants {
        static let baseURL = "gateway.marvel.com"
        static let defaultLimit = 20
    }
    
    enum RequestType: String {
      case GET
      case POST
    }

    static func createRequest(
        host: String = APIConstants.baseURL,
        requestType: RequestType,
        path: String,
        params: [String: Any] = [:],
        urlParams: [String: String?],
        headers: [String: String] = [:]
    ) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path

        let timeStamp = "\(Date().timeIntervalSince1970)"

        let hash = (timeStamp + ArkanaKeys.Keys.Global().marvelPrivateKey
                    + ArkanaKeys.Keys.Global().marvelPublicKey).md5

        /// Add default query params
        var queryParamsList: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: ArkanaKeys.Keys.Global().marvelPublicKey),
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash)
        ]

        if !urlParams.isEmpty {
            queryParamsList.append(contentsOf: urlParams.map { URLQueryItem(name: $0, value: $1) })
        }

        components.queryItems = queryParamsList

        guard let url = components.url else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
    }
}

private extension String {
    
    var md5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let data = data(using: String.Encoding.utf8) {
            _ = data.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(data.count), &digest)
            }
        }

        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
