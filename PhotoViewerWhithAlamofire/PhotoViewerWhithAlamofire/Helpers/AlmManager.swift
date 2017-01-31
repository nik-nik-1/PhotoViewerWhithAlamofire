//
//  AlmManager.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 14.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

struct Router500px {
	var urlToConnect: URLConvertible = ""
	var parametersToConnect: [String : AnyObject] = [:]

	fileprivate let defaulttypeOfURL = Five100px.TypeOfURL.Photos

	init (imageSize: Five100px.ImageSize, photoId: String?) {
		urlToConnect        = getUrlStringToConnect(defaulttypeOfURL, photoId: photoId)
		parametersToConnect = getParametersToConnect(imageSize, photoId: photoId)
	}

	init (imageSize: Five100px.ImageSize) {
		urlToConnect        = getUrlStringToConnect(defaulttypeOfURL, photoId: nil)
		parametersToConnect = getParametersToConnect(imageSize, photoId: nil)
	}

	init () {
		urlToConnect        = getUrlStringToConnect(defaulttypeOfURL, photoId: nil)
		parametersToConnect = getParametersToConnect(Five100px.ImageSize.tiny, photoId: nil)
	}

	fileprivate func getUrlStringToConnect (_ typeOfURL: Five100px.TypeOfURL?,
	                                    photoId: String?)
																		-> URLConvertible {

		var tTypeOfURL: String = ""
		if  let tempTypeOfURL = typeOfURL {
			tTypeOfURL = String(tempTypeOfURL.rawValue)
		} else {
			tTypeOfURL = String(defaulttypeOfURL.rawValue)
		}

		var tphotoId: String = ""
		if let tempPhotoId = photoId {
			tphotoId = "/"+tempPhotoId
		}
		let URL = Foundation.URL(string: GeneralValues.urlOf500px + tTypeOfURL + tphotoId)!

		return URL
	}

	fileprivate func getParametersToConnect (_ imageSize: Five100px.ImageSize?,
	                                     photoId: String?)
																		-> [String : AnyObject] {

		let tempImageSize: String = (imageSize != nil ? String(imageSize!.rawValue) : "0")
		var parameters: [String: AnyObject] = ["consumer_key": GeneralValues.consumer_keyFor500px as AnyObject,
		                                       "image_size": tempImageSize as AnyObject]

		if photoId != nil {
			//something, if needed ...
		} else {
			parameters.updateValue(String(GeneralValues.pageToLoad) as AnyObject, forKey: "page")
			parameters.updateValue(GeneralValues.feature as AnyObject, forKey: "feature")
		}

		return parameters
	}

}

struct Five100px {


	enum ImageSize: Int {
		case tiny = 1
		case small = 2
		case medium = 3
		case large = 4
		case xLarge = 5
	}

	enum TypeOfURL: String {
		case Photos = "/photos"
		//case ImageFromId = "/photos"
	}

}
