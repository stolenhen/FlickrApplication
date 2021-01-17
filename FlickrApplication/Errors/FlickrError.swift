//
//  FlickrError.swift
//  FlickrApplication
//
//  Created by stolenhen on 17.01.2021.
//

import Foundation

enum FlickrError: Error {
    case badURL
    case noInternetConnection(String)
    case serverError(String)
    case unknownError(String)
    
    var localizedDescription: String {
       
        switch self {
        case .badURL:
            return "URL is not supported"
        case let .noInternetConnection(description):
            return "\(description)"
        case let .serverError(description):
            return "\(description)"
        case let .unknownError(description):
            return "\(description)"
        }
    }
}
