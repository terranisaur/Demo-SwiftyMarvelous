//
//  BaseResponseModel.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//

import Foundation

public struct BaseResponseModel<T: Codable>: Codable {
    public let code: Int
    public let status: String
    public let data: T
}
