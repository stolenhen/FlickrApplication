//
//  Constants.swift
//  FlickrApplication
//
//  Created by stolenhen on 16.01.2021.
//

import Foundation

enum Constants {
    
    static let apiKey: String = "988082d9a1d0677073a3ba7b45459ceb"
    
    static var userID: String? {
        let userID = "66956608%40N06"
        return userID.removingPercentEncoding
    }
}
