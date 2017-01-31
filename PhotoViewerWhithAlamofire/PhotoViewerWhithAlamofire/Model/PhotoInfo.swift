//
//  PhotoInfo.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import Foundation

class PhotoInfo: NSObject {
	let id: Int // swiftlint:disable:this variable_name
	let url: String
	var photoIndex: Int!

	var name: String?

	var favoritesCount: Int?
	var votesCount: Int?
	var commentsCount: Int?

	var highest: Float?
	var pulse: Float?
	var views: Int?
	var camera: String?
	var desc: String?

	init(id: Int, url: String) {
		// swiftlint:disable:previous variable_name
		self.id = id
		self.url = url
	}

	required init(response: HTTPURLResponse, representation: AnyObject) {
		self.id = (representation.value(forKeyPath: "photo.id") as? Int)!
		self.url = (representation.value(forKeyPath: "photo.image_url") as? String)!

		self.favoritesCount = representation.value(forKeyPath: "photo.favorites_count") as? Int
		self.votesCount = representation.value(forKeyPath: "photo.votes_count") as? Int
		self.commentsCount = representation.value(forKeyPath: "photo.comments_count") as? Int
		self.highest = representation.value(forKeyPath: "photo.highest_rating") as? Float
		self.pulse = representation.value(forKeyPath: "photo.rating") as? Float
		self.views = representation.value(forKeyPath: "photo.times_viewed") as? Int
		self.camera = representation.value(forKeyPath: "photo.camera") as? String
		self.desc = representation.value(forKeyPath: "photo.description") as? String
		self.name = representation.value(forKeyPath: "photo.name") as? String
	}

	override func isEqual(_ object: Any!) -> Bool {
		return (object as? PhotoInfo)!.id == self.id
	}

	override var hash: Int {
		return (self as PhotoInfo).id
	}
}
