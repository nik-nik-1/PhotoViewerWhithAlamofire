//
//  ImageView.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

protocol workWhithControllerViewFromImageCollectionView {

	func setCorrectActiveCellInView(_ activeItem: PhotoInfoOM?)
	func getMorePhoto(_ scrollView: UIScrollView)

}

class ImageCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

	var photos: [PhotoInfoOM] = [] {//= NSMutableOrderedSet(){
		willSet (newItems) {

		}
		didSet {

			if self.updateCollectionWhenAddednewElement {
				self.reloadData()
			}
		}
	}


	var updateCollectionWhenAddednewElement: Bool = true
	var controllerDelegate: workWhithControllerViewFromImageCollectionView?

	required init? (coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		self.dataSource = self
		self.delegate   = self
	}


	//MARK: UICollectionViewDataSource
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// swiftlint:disable:previous line_length
		return photos.count
	}

	// The cell that is returned must be retrieved from a call to -
	//dequeueReusableCellWithReuseIdentifier:forIndexPath:
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// swiftlint:disable:previous line_length

		// swiftlint:disable force_cast
		// swiftlint:disable line_length
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
		// swiftlint:enable force_cast
		// swiftlint:enable line_length

		let imageItemCell = cell //as! ImageCollectionViewCell

		let massPhotoItemElem = photos.filter ({ return $0.photoIndex == indexPath.row })
		if massPhotoItemElem.count > 0 {
			imageItemCell.photoItemElem = massPhotoItemElem[0]

		} else if massPhotoItemElem.count > 1 {

			print("Errror !!!! ")
		}

		return cell
	}

	//MARK: UICollectionViewDelegate
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		// swiftlint:disable:previous line_length

	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// swiftlint:disable:previous line_length

		// swiftlint:disable line_length
		//        performSegueWithIdentifier("ShowPhoto", sender: (self.photos.objectAtIndex(indexPath.item) as! PhotoInfo).id)

		//controllerDelegate?.setCorrectActiveCellInView(photos[indexPath.row]) //NOT Work good! get start behind the PrepareForSeguei - but needed to be first
		// swiftlint:disable:enable line_length
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		controllerDelegate?.getMorePhoto(scrollView)
	}

}
