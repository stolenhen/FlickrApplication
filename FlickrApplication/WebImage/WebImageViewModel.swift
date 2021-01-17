//
//  WebImageViewModel.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import UIKit.UIImage
import Combine

final class WebImageViewModel: ObservableObject {
    
    @Published
    var image: UIImage?
    
    private var anyCancellable = Set<AnyCancellable>()
    
    private let imageLoader: ImageLoaderProtocol
    
    init(imageLoader: ImageLoaderProtocol = ImageLoader()) {
        self.imageLoader = imageLoader
    }

    func fetchImage(for photoDescription: PhotoDiscription) {
        imageLoader
            .loadImage(photoDescription)
            .assign(to: \.image, on: self)
            .store(in: &anyCancellable)
    }
}
