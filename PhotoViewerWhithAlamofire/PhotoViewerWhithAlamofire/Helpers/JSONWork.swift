//
//  JSONWork.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class JSONWork {
    
    //MARK: Work with Alamofire Only
        static func getJSONDataFromURlmanualy (Router:Router500px, callback: ((data:[PhotoInfoOM]) -> Void)) {
    
            Alamofire.request(.GET, Router.urlToConnect, parameters: Router.parametersToConnect).responseJSON() {
    
                response in switch response.result {
                case .Success(let JSONData):
                    // print("Success with JSON: \(JSONData)")
    //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
    
                        let JSON = JSONData as! NSDictionary
                        let photoInfos = getPhotoInfoArrayFromData (JSON)
    
                        callback(data: photoInfos)
    //                }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
    
    
    static func getPhotoInfoArrayFromData (JSON:NSDictionary) -> [PhotoInfoOM]{
        
        var photoInfos:[PhotoInfoOM] = []
        
        let valueForOne     = JSON.valueForKey("photo")
        let valueFoArray    = JSON.valueForKey("photos")
        
        if valueFoArray != nil {
            
            photoInfos = (valueFoArray as! [NSDictionary]).filter({
                ($0["nsfw"] as! Bool) == false
            }).map {
                PhotoInfoOM(id: $0["id"] as! Int, url: $0["image_url"] as! String)
            }
        } else {
            let photoInfoElement = PhotoInfoOM(id: valueForOne!["id"] as! Int, url: valueForOne!["image_url"] as! String)
            photoInfos.append(photoInfoElement)
        }
        
        
        return photoInfos
    }
    
    //MARK: Work with Alamofire + ObjectMapper
    //
    //for debug can be used:
    //        ..).responseString { response in
    //            print("Success: \(response.result.isSuccess)")
    //            print("Response String: \(response.result.value)")
    //        }
    
    static func getJSONDataFromURl (Router:Router500px, callback: ((data:[PhotoInfoOM]) -> Void)) {
        
        Alamofire.request(.GET, Router.urlToConnect, parameters: Router.parametersToConnect)
            .responseObject { (response: Response<PhotoInfoOMDataFromULR, NSError>) in
                
                switch response.result {
                    
                case .Success(let data):
                    
                    var photosToReturn: [PhotoInfoOM] = []
                    if (data.photo != nil) && (data.photos.count == 0) {
                        //this is 1 photo for request, let's create aray for callBack it
                        photosToReturn.append(data.photo!)
                    } else {
                        photosToReturn = data.photos
                    }
                    
                    callback(data: photosToReturn)
                    
                case .Failure(let error):
                    debugPrint("getEvents error: \(error)")
                }
        }
    }
    
    
    
    static func getImageFromJSONData (imageURL:String, callBack: ((Image: UIImage) -> Void)) {
        
        Alamofire.request(.GET, imageURL).responseData	() {
            response in switch response.result {
            case .Success(let URLData):
                
                let image = UIImage(data: URLData)
                
                callBack(Image: image!)
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    static func getImageFromJSONData (Router:Router500px, callBack: ((Image: UIImage) -> Void)) {
        
        getJSONDataFromURl(Router) {(photoInfos) -> Void in
            if photoInfos.count > 0 {
                
                let firstElem = photoInfos[0]
                
                getImageFromJSONData (firstElem.url!, callBack: callBack)
            }
        }
    }
    
    
}