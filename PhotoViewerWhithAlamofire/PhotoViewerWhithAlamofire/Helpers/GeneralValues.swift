//
//  GeneralValues.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

struct GeneralValues {

	// swiftlint:disable:next variable_name
	static let consumer_keyFor500px: String = "NDn26JUhxNNHcvj5Zmt19McRKoK2jS25RQzyBIfA"
	static let urlOf500px: String = "https://api.500px.com/v1"
	static var pageToLoad: Int = 0
	static var feature: String = "popular"
	static let alphaChannelForSideMenu: CGFloat = 0.8

	static var photos: Set<PhotoInfoOM> {//= NSMutableOrderedSet(){
		get {return GeneralValues.photos}
		set {self.photos = newValue}
	}

}
