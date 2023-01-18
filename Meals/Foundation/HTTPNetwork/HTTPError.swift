//
//  HTTPError.swift
//  Meals
//
//  Created by Yongfeng on 1/15/23.
//

import Foundation

enum HTTPError: Error {
    case invalidURL(url: String)
    case responseIsNull
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "URL is not valid: \(url)"
        case .responseIsNull:
            return "Response is null."
        }
    }
}

enum EncodingFailedReason: LocalizedError {
    case codingKeyNotFound(String)
}

extension EncodingFailedReason {
    var localizedDescription: String {
        switch self {
        case .codingKeyNotFound(let key):
            return "Coding key not found: \(key)"
        }
    }
}
