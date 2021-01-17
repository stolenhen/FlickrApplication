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
        
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: GridMode.async(spacing: 2, columnsCount: 2).columns, spacing: 2) {
                ForEach(viewModel.popular) { description in
                    NavigationLink(destination:
                                    DetailPhotoView(photoDescription: description)) {
                        WebImageView(photoDescription: description)
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 50, maxWidth: .infinity)
                            .frame(height: 250)
                            .clipped()
                    }
                }
            }
            .modifier(ErrorPresenter(presenter: $viewModel.presenter))
        }
        .overlay(
            Group {
                if viewModel.popular.isEmpty {
                    VStack(alignment: .center, spacing: 5) {
                        Text("LOADING...")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        ProgressView()
                    }
                }
            }
        )
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
