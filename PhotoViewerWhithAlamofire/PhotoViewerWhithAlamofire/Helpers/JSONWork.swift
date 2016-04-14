//
//  JSONWork.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Alamofire

class JSONWork {
    
    static func setRouter(imageSize:Five100px.ImageSize) -> (NSMutableURLRequest, NSError?) {
       
        let URL = NSURL(string: GeneralValues.urlOf500px+"/photos")!
        let request = NSMutableURLRequest(URL: URL)
        
       let parameters:[String : AnyObject] = ["consumer_key": GeneralValues.consumer_keyFor500px, "image_size":String(imageSize.rawValue), "page": "\(GeneralValues.pageToLoad)", "feature":GeneralValues.feature]
        let encoding = Alamofire.ParameterEncoding.URL
       
        return encoding.encode(request, parameters: parameters)
    }
    
//    static func getJSONDataFromURl (imageSize:Five100px.ImageSize, callback: ((data:[PhotoInfo]) -> Void)) {
//        
//        Alamofire.request(.GET, GeneralValues.urlOf500px+"/photos", parameters: ["consumer_key": GeneralValues.consumer_keyFor500px, "image_size":String(imageSize.rawValue), "page": "\(GeneralValues.pageToLoad)", "feature":GeneralValues.feature]).responseJSON() {
//            
//            response in switch response.result {
//            case .Success(let JSONData):
//                // print("Success with JSON: \(JSONData)")
//                
//                let JSON = JSONData as! NSDictionary
//                
//                let photoInfos = (JSON.valueForKey("photos") as! [NSDictionary]).filter({
//                    ($0["nsfw"] as! Bool) == false
//                }).map {
//                    PhotoInfo(id: $0["id"] as! Int, url: $0["image_url"] as! String)
//                }
//                
//                callback(data: photoInfos)
//                
//            case .Failure(let error):
//                print("Request failed with error: \(error)")
//            }
//        }
//    }
    
    
    static func getJSONDataFromURl (imageSize:Five100px.ImageSize, callback: ((data:[PhotoInfo]) -> Void)) {
        
        Alamofire.request(.GET, GeneralValues.urlOf500px+"/photos", parameters: ["consumer_key": GeneralValues.consumer_keyFor500px, "image_size":String(imageSize.rawValue), "page": "\(GeneralValues.pageToLoad)", "feature":GeneralValues.feature]).responseJSON() {
            
            response in switch response.result {
            case .Success(let JSONData):
                // print("Success with JSON: \(JSONData)")
                
                let JSON = JSONData as! NSDictionary
                
                let photoInfos = (JSON.valueForKey("photos") as! [NSDictionary]).filter({
                    ($0["nsfw"] as! Bool) == false
                }).map {
                    PhotoInfo(id: $0["id"] as! Int, url: $0["image_url"] as! String)
                }
                
                callback(data: photoInfos)
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
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
    
}