//
//  JSONWork.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Alamofire

class JSONWork {
    
    static func getJSONDataFromURl (callback: ((data:[PhotoInfo]) -> Void)) {
        
        Alamofire.request(.GET, GeneralValues.urlOf500px, parameters: ["consumer_key": GeneralValues.consumer_keyFor500px]).responseJSON() {
            (JSON)//(_, _, JSON, _)
            in
            //print(JSON)
            //
            print(JSON)
            
            //JSON.data
            
            let photoInfos = (JSON.data!.valueForKey("photos") as! [NSDictionary]).filter({
                ($0["nsfw"] as! Bool) == false
            }).map {
                PhotoInfo(id: $0["id"] as! Int, url: $0["image_url"] as! String)
            }

            
            callback(data: photoInfos)
        }
    }
    
}