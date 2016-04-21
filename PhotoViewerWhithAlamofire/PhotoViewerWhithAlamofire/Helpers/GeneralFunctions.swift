//
//  GeneralFunctions.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 20.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation

class GeneralFunctions {
   
    class func getPhotoIndexFromItemElement (receivedCell:PhotoInfoOM?) -> Int{
        return (receivedCell != nil ? receivedCell!.photoIndex : 0)
    }
    
}
