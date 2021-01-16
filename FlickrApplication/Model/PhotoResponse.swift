//
//  PhotoResponse.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import Foundation

struct PhotoResponse: Codable {
    
    let photo: [Photo]
    
    private enum PhotosKey: String, CodingKey {
        case photos
    }
    
    private enum PhotoKey: String, CodingKey {
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotosKey.self)
        let photoContainer = try container.nestedContainer(keyedBy: PhotoKey.self, forKey: .photos)
        self.photo = try photoContainer.decode([Photo].self, forKey: .photo)
    }
}

extension PhotoResponse {
    
    struct Photo: Codable {
        let id: String?
        let secret: String?
        let server: String?
        let farm: Int?
        let title: String?
    }
}

