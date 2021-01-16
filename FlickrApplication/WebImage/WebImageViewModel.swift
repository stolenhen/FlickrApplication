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

    func fetchImage(for photoDescription: PhotoDiscription,
                    loader: ImageLoaderProtocol = ImageLoader.shared) {
        loader
            .loadImage(photoDescription)
            .assign(to: \.image, on: self)
            .store(in: &anyCancellable)
    }
}
