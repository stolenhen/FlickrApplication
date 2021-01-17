//
//  PopularPhotosView.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import SwiftUI

struct PopularPhotosView: View {
    
    @ObservedObject var viewModel: PopularPhotosViewModel
    
    var body: some View {
        
        List {
            ForEach(viewModel.popular) { description in
                NavigationLink(destination:
                                DetailPhotoView(photoDescription: description)) {
                    WebImageView(photoDescription: description)
                        .frame(width: UIScreen.main.bounds.width * 0.8,
                               height: UIScreen.main.bounds.height * 0.2)
                        .cornerRadius(30)
                }
            }
            .modifier(ErrorPresenter(presenter: $viewModel.presenter))
        }
        .onAppear {
            viewModel.getPhotos()
        }
    }
}

struct PopularPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


