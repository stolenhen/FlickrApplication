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
    func loadImage(_ photo: PhotoDiscription) -> ImageResponse
}

final class ImageLoader: ImageLoaderProtocol {
    
    // MARK: - Properties
    
    private let cache = NSCache <NSString, UIImage>()
    
    static let shared = ImageLoader()
    
    private init() {}
    
    // MARK: - Functions
    
    func loadImage(_ photo: PhotoDiscription) -> ImageResponse {
        
        let path = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        
        guard let url = URL(string: path) else {
            return
                Just(nil).eraseToAnyPublisher()
        }
        
        guard
            cache.object(forKey: path as NSString) != nil else {
            
            return
                URLSession
                .shared
                .dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .utility))
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .compactMap { [ self ] in
                    if let image = UIImage(data: $0) {
                        cache.setObject(image, forKey: path as NSString)
                    }
                    return UIImage(data: $0)
                }
                .catch {_ in Just(nil) }
                .eraseToAnyPublisher()
        }
        
        if let image = cache.object(forKey: path as NSString) {
            return
                Just (image)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        
        return
            Just(nil).eraseToAnyPublisher()
    }
}
