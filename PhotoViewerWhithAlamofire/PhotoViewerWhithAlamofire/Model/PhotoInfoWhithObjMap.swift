//
//  PhotoInfoWhithObjMap.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 18.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoInfoOM: NSObject, Mappable {

    var id: Int?
    var url: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        id  <- map["id"]
        url <- map["url"]
       
    }
}
