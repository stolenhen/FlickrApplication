//
//  PopularPhotosView.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import SwiftUI

struct PopularPhotosView: View {
    
    @StateObject
    private var viewModel = PopularPhotosViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical) {
                ForEach(viewModel.popular) { description in
                    NavigationLink(destination:
                                    DetailPhotoView(photoDescription: description)) {
                        WebImageView(photoDescription: description)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 200)
                            .cornerRadius(30)
                    }
                }
            }
            .onAppear { viewModel.getPhotos() }
            .navigationBarTitle("Popular photos")
        }
        .environment(\.locale, .init(identifier: viewModel.currentLanguage))
    }
}

struct PopularPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


