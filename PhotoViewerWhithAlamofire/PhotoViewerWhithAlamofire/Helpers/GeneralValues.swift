//
//  GeneralValues.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

struct Five100px {
    enum ImageSize: Int {
        case Tiny = 1
        case Small = 2
        case Medium = 3
        case Large = 4
        case XLarge = 5
    }
}

struct GeneralValues {
    static let consumer_keyFor500px: String = "NDn26JUhxNNHcvj5Zmt19McRKoK2jS25RQzyBIfA"
    static let urlOf500px: String = "https://api.500px.com/v1/photos"
}
