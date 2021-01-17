//
//  ContentView.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    private var viewModel = PopularPhotosViewModel()
    
    var body: some View {
        NavigationView {
            PopularPhotosView(viewModel: viewModel)
                .navigationBarTitle("Popular photos")
        }
        .environment(\.locale, .init(identifier: viewModel.currentLanguage))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
