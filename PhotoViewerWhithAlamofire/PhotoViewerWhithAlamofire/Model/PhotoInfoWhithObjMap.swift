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

	var id: Int?// swiftlint:disable:this variable_name
	var url: String?
	var photoIndex: Int!

	override func isEqual(object: AnyObject!) -> Bool {
		return (object as? PhotoInfoOM)!.id == self.id
	}

	override var hash: Int {
		return (self as PhotoInfoOM).id!
	}

	init(id: Int, url: String) {
		// swiftlint:disable:previous variable_name
		self.id = id
		self.url = url
	}

	//MARK: protocol Mappable
	required init?(_ map: Map) {

	}

	func mapping(map: Map) {
		id  <- map["id"]
		url <- map["image_url"]
	}

}

class PhotoInfoOMDataFromULR: Mappable {

	var current_page: Int?// swiftlint:disable:this variable_name
	var total_pages: Int?// swiftlint:disable:this variable_name
	var feature: String?
	var photos: [PhotoInfoOM] = []
	var photo: PhotoInfoOM?
	var filterCategory: String?

	//MARK: protocol Mappable
	required init?(_ map: Map) {

	}

	func mapping(map: Map) {
		current_page    <- map["current_page"]
		total_pages     <- map["total_pages"]
		feature         <- map["feature"]
		photos          <- map["photos"]
		photo           <- map["photo"]
		filterCategory  <- map["filters.category", nested: false]

	}

}
