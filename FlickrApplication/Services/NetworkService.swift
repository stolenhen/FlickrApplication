//
//  NetworkService.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import Foundation
import Combine

typealias FlickrResponse = AnyPublisher<PhotoResponse, Error>

protocol NetworkServiceProtocol {
    func getPhotos(endpoint: Endpoint) -> FlickrResponse
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

final class NetworkService: NetworkServiceProtocol {
    
    func getPhotos(endpoint: Endpoint) -> FlickrResponse {
        
        guard let url = endpoint.url else { fatalError("Unknown URL") }
        print(url)
        return
            URLSession
            .shared
            .dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: PhotoResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension Endpoint {
    
    static func getInfo() -> Endpoint {
        
        return Endpoint(path: "/services/rest/",
                        queryItems: [ URLQueryItem(name: "method", value: "flickr.photos.getPopular"),
                                      URLQueryItem(name: "api_key", value: Constants.apiKey),
                                      URLQueryItem(name: "user_id", value: Constants.userID),
                                      URLQueryItem(name: "format", value: "json"),
                                      URLQueryItem(name: "nojsoncallback", value: "1") ])
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "flickr.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
