//
//  PhotoComment.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation

class Comment {
    let userFullname: String
    let userPictureURL: String
    let commentBody: String

    init(JSON: AnyObject) {
        userFullname = (JSON.valueForKeyPath("user.fullname") as? String)!
        userPictureURL = (JSON.valueForKeyPath("user.userpic_url") as? String)!
        commentBody = (JSON.valueForKeyPath("body") as? String)!
    }
}
