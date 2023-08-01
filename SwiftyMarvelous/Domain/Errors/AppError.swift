//
//  AppError.swift
//  SwiftyMarvel
//
//  Created by Alex Thurston on 07/07/2023.
//

import Foundation

public enum AppError: Error, Equatable {
    case networkError(String)
    case parsingError(String)
    case serverError(String)
    case unknownError(String)
}

public extension Error {
    
    /// Converts any error to an `AppError` object.
    var toAppError: AppError {
        if self is NetworkError {
            return .networkError("Network Error")
        }
        return AppError.unknownError("Unknown Error")
    }
}
