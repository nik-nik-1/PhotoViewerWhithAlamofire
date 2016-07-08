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
	static func getJSONDataFromURlmanualy (router: Router500px, callback: ((data: [PhotoInfoOM]) -> Void)) {
		// swiftlint:disable:previous line_length
		// swiftlint:disable:next line_length
		Alamofire.request(.GET, router.urlToConnect, parameters: router.parametersToConnect).responseJSON() {

			response in switch response.result {
			case .Success(let JSONData):

				let jSON = (JSONData as? NSDictionary)!
				let photoInfos = getPhotoInfoArrayFromData (jSON)

				callback(data: photoInfos)

			case .Failure(let error):
				print("Request failed with error: \(error)")
			}
		}
	}


	static func getPhotoInfoArrayFromData (data: NSDictionary) -> [PhotoInfoOM] {

		var photoInfos: [PhotoInfoOM] = []

		let valueForOne     = data.valueForKey("photo")
		let valueFoArray    = data.valueForKey("photos")

		if valueFoArray != nil {

			photoInfos = (valueFoArray as? [NSDictionary])!.filter({
				($0["nsfw"] as? Bool) == false
			}).map {
				PhotoInfoOM(id: ($0["id"] as? Int)!, url: ($0["image_url"] as? String)!)
			}
		} else {
			// swiftlint:disable:next line_length
			let photoInfoElement = PhotoInfoOM(id: (valueForOne!["id"] as? Int)!, url: (valueForOne!["image_url"] as? String)!)
			photoInfos.append(photoInfoElement)
		}

		return photoInfos
	}

	static func getPhotoInfoArrayFromData (data: PhotoInfoOMDataFromULR) -> [PhotoInfoOM] {

		var photoInfos: [PhotoInfoOM] = []

		if (data.photo != nil) && (data.photos.count == 0) {
			//this is 1 photo for request, let's create aray for callBack it
			photoInfos.append(data.photo!)
		} else {
			photoInfos = data.photos
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

	static func getJSONDataFromURl (router: Router500px, callback: ((data: [PhotoInfoOM]) -> Void)) {

		Alamofire.request(.GET, router.urlToConnect, parameters: router.parametersToConnect)
			.responseObject { (response: Response<PhotoInfoOMDataFromULR, NSError>) in

				switch response.result {

				case .Success(let data):

					let photosToReturn = getPhotoInfoArrayFromData (data)

					callback(data: photosToReturn)

				case .Failure(let error):
					debugPrint("getEvents error: \(error)")
				}
		}
	}

	static func getImageFromJSONData (imageURL: String, callBack: ((Image: UIImage) -> Void)) {

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

	static func getImageFromJSONData (router: Router500px, callBack: ((Image: UIImage) -> Void)) {

		getJSONDataFromURl(router) {(photoInfos) -> Void in
			if photoInfos.count > 0 {

				let firstElem = photoInfos[0]

				getImageFromJSONData (firstElem.url!, callBack: callBack)
			}
		}
	}

}
