//
//  BaseResponse.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//

import Foundation

public struct BaseResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let data: T
}
