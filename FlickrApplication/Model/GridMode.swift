//
//  GridMode.swift
//  FlickrApplication
//
//  Created by stolenhen on 17.01.2021.
//

import SwiftUI


enum GridMode {
    
    case async(spacing: CGFloat, columnsCount: Int)
    
    var columns: [GridItem] {
        switch self {
        case let .async(spacing, columnsCount):
            return
                Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnsCount)
        }
    }
}
