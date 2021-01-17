//
//  PopularPhotosViewModel.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import Foundation
import Combine

final class PopularPhotosViewModel: ObservableObject {
    
    @Published
    private(set) var popular: [PhotoDiscription] = []
    
    @Published var presenter: Presenter?
    
    private var anyCancellable = Set<AnyCancellable>()
    private let networkService: NetworkServiceProtocol
    
    let currentLanguage = Locale.current.identifier
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getPhotos() {
        networkService
            .getPhotos(endpoint: .getInfo())
            .map (\.photo)
            .sink(
                receiveCompletion: { [ self ] in
                    switch $0 {
                    case .finished: break
                    case let .failure(error):
                         presenter = .errorAlert(error: error)
                    }
                },
                receiveValue: { [ self ] in
                    popular = $0.map(PhotoDiscription.init)
                }
            )
            .store(in: &anyCancellable)
    }
}

// MARK: - PhotoWrapper

struct PhotoDiscription: Identifiable {
    
    let photo: PhotoResponse.Photo
    
    var id: String { photo.id ?? UUID().uuidString }
    var title: String { photo.title ?? "Unknown photo" }
    var farm: Int { photo.farm ?? 0 }
    var secret: String { photo.secret ?? "0" }
    var server: String { photo.server ?? "0" }
}
