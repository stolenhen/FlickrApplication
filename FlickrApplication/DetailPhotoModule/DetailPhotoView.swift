//
//  DetailPhotoView.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import SwiftUI

struct DetailPhotoView: View {
    
    let photoDescription: PhotoDiscription
    private let screen = UIScreen.main.bounds
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            WebImageView(photoDescription: photoDescription)
                .frame(width: screen.width, height: screen.height / 3)
                .clipped()
            
            Text(photoDescription.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal, 5)
            
            Spacer()
        }
        .navigationBarTitle("Photo details", displayMode: .inline)
    }
}
