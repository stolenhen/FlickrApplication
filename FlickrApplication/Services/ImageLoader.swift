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
    
    private static let cache = NSCache <NSString, UIImage>()
    
    // MARK: - Functions
    
    func loadImage(_ photo: PhotoDiscription?) -> ImageResponse {
        
        guard let url = createURL(for: photo) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        if let image = ImageLoader.cache.object(forKey: url.path as NSString) {
            return Just(image)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
            return
                URLSession
                .shared
                .dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .map(UIImage.init)
                .handleEvents(receiveOutput: {
                    guard let image = $0 else  { return }
                    ImageLoader.cache.setObject(image, forKey: url.path as NSString)
                    })
                .catch {_ in Just(nil) }
                .eraseToAnyPublisher()
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
