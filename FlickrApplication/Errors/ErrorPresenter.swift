//
//  ErrorPresenter.swift
//  FlickrApplication
//
//  Created by stolenhen on 17.01.2021.
//

import SwiftUI

enum Presenter: Identifiable {
    
    var id: String { UUID().uuidString }
    
    case errorAlert(error: FlickrError)
}

struct ErrorPresenter: ViewModifier {
    
    @Binding
    var presenter: Presenter?
    
    func body(content: Content) -> some View {
        switch presenter {
        case let .errorAlert(error): return
            content.alert(item: $presenter) { _ in
                Alert(title: Text("Warning"),
                      message: Text(error.localizedDescription),
                      dismissButton: .destructive(Text("Ok")))
            }
            .transformToAny
        default: return
            content
            .transformToAny
        }
    }
}
