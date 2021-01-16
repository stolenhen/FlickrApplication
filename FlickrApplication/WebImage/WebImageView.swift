//
//  WebImageView.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import SwiftUI

struct WebImageView: View {
   
    @StateObject
    private var viewModel = WebImageViewModel()
    let photoDescription: PhotoDiscription
    
    var body: some View {
        
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            else {
                Color(.lightGray)
            }
        }
        .onAppear {
            viewModel.fetchImage(for: photoDescription)
        }
    }
}
