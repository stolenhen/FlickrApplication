//
//  ImageLoader.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import UIKit.UIImage
import Combine

typealias ImageResponse = AnyPublisher<UIImage?, Never>

protocol ImageLoaderProtocol {
    func loadImage(_ photo: PhotoDiscription?) -> ImageResponse
}

final class ImageLoader: ImageLoaderProtocol {
    
    // MARK: - Properties
    
    private let cache = NSCache <NSString, UIImage>()
    
    static let shared = ImageLoader()
    
    private init() {}
    
    // MARK: - Functions
    
    func loadImage(_ photo: PhotoDiscription?) -> ImageResponse {
        
        guard let url = createURL(for: photo) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        guard
            cache.object(forKey: url.path as NSString) != nil else {
            
            return
                URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .compactMap { [ self ] in
                    if let image = UIImage(data: $0) {
                        cache.setObject(image, forKey: url.path as NSString)
                    }
                    return UIImage(data: $0)
                }
                .catch {_ in Just(nil) }
                .eraseToAnyPublisher()
        }
        
        if let image = cache.object(forKey: url.path as NSString) {
            return
                Just (image)
                .subscribe(on: DispatchQueue.global(qos: .userInteractive))
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        return
            Just(nil).eraseToAnyPublisher()
    }
}

extension ImageLoader {
    
    private func createURL(for photoDiscription: PhotoDiscription?) -> URL? {
        
        guard let photoDiscription = photoDiscription else { return nil }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "farm\(photoDiscription.farm).staticflickr.com"
        components.path = "/\(photoDiscription.server)/\(photoDiscription.id)_\(photoDiscription.secret).jpg"
        return components.url
    }
}
