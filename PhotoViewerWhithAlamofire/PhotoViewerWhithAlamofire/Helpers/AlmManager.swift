//
//  AlmManager.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 14.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit
import Alamofire


struct Five100px {
    
    
    enum ImageSize: Int {
        case Tiny = 1
        case Small = 2
        case Medium = 3 
        case Large = 4
        case XLarge = 5
    }
    
    
//    enum Router: URLRequestConvertible {
//        static let baseURLString = GeneralValues.urlOf500px
//        static let consumerKey = GeneralValues.consumer_keyFor500px
//        
//        case PopularPhotos(Int)
//        case PhotoInfo(Int, ImageSize)
//        case Comments(Int, Int)
//        
//        var URLRequest: NSURLRequest {
//            let (path: String, parameters:[String: AnyObject]) = {
//                switch self {
//                case .PopularPhotos (let page):
//                    let params = ["consumer_key": Router.consumerKey, "page": "\(page)", "feature": "popular", "rpp": "50",  "include_store": "store_download", "include_states": "votes"]
//                    return ("/photos", params)
//                case .PhotoInfo(let photoID, let imageSize):
//                    var params = ["consumer_key": Router.consumerKey, "image_size": "\(imageSize.rawValue)"]
//                    return ("/photos/\(photoID)", params)
////                case .Comments(let photoID, let commentsPage):
////                    var params = ["consumer_key": Router.consumerKey, "comments": "1", "comments_page": "\(commentsPage)"]
////                    return ("/photos/\(photoID)/comments", params)
//                }
//            }()
//            
//            let URL = NSURL(string: Router.baseURLString)
//            let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
//            let encoding = Alamofire.ParameterEncoding.URL
//            
//            return encoding.encode(URLRequest, parameters: parameters).0
//        }
//    }
    
    
}