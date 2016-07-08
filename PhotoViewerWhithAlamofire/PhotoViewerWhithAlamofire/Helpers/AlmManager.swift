//
//  AlmManager.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 14.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit
import Alamofire

struct Router500px {
	var urlToConnect: URLStringConvertible = ""
	var parametersToConnect: [String : AnyObject] = [:]

	private let defaulttypeOfURL = Five100px.TypeOfURL.Photos

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
		parametersToConnect = getParametersToConnect(Five100px.ImageSize.Tiny, photoId: nil)
	}

	private func getUrlStringToConnect (typeOfURL: Five100px.TypeOfURL?,
	                                    photoId: String?)
																		-> URLStringConvertible {

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
		let URL = NSURL(string: GeneralValues.urlOf500px + tTypeOfURL + tphotoId)!

		return URL
	}

	private func getParametersToConnect (imageSize: Five100px.ImageSize?,
	                                     photoId: String?)
																		-> [String : AnyObject] {

		let tempImageSize: String = (imageSize != nil ? String(imageSize!.rawValue) : "0")
		var parameters: [String: AnyObject] = ["consumer_key": GeneralValues.consumer_keyFor500px,
		                                       "image_size": tempImageSize]

		if photoId != nil {
			//something, if needed ...
		} else {
			parameters.updateValue(String(GeneralValues.pageToLoad), forKey: "page")
			parameters.updateValue(GeneralValues.feature, forKey: "feature")
		}

		return parameters
	}

}

struct Five100px {


	enum ImageSize: Int {
		case Tiny = 1
		case Small = 2
		case Medium = 3
		case Large = 4
		case XLarge = 5
	}

	enum TypeOfURL: String {
		case Photos = "/photos"
		//case ImageFromId = "/photos"
	}

}
