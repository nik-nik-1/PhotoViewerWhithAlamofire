//
//  ImageGridFlowLayuot.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ImageGridFlowLayout: UICollectionViewFlowLayout {

	let iDOfInstanse: String = "GridFlowLayout"

	// here you can define the height of each cell
	let itemHeight: CGFloat = 100

	override init() {
		super.init()
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupLayout()
	}

	/**
	Sets up the layout for the collectionView.
	//1pt distance between each cell and
	//1pt distance between each row plus use a vertical layout
	*/
	func setupLayout() {
		minimumInteritemSpacing = 1
		minimumLineSpacing = 1
		scrollDirection = .vertical
	}

	/// here we define the width of each cell,
	//creating a 2 column layout.
	//In case you would create 3 columns, change the number 2 to 3
	func itemWidth() -> CGFloat {
		// swiftlint:disable:next legacy_cggeometry_functions
		return ((collectionView?.frame)!.width/3)-1
	}

	override var itemSize: CGSize {

		set {
			// swiftlint:disable:next line_length
			self.itemSize = CGSize.init(width: itemWidth(), height: itemHeight)//CGSizeMake(itemWidth(), itemHeight)
		}
		get {
			return CGSize.init(width: itemWidth(), height: itemHeight)//CGSizeMake(itemWidth(), itemHeight)
		}
	}

	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
// swiftlint:disable:previous line_length
		return collectionView!.contentOffset
	}

}
