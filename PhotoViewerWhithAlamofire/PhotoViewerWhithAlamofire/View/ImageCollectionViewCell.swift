//
//  ImageCollectionViewCell.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!

	var needtoInstalImageInCell: Bool = true

	var photoItemElem: PhotoInfoOM! {
		willSet (newPhotoItemElem) {

			imageView.image = UIImage(named: "noimage.png")
		}

		didSet {

			if needtoInstalImageInCell {

				spinner.startAnimating()
				JSONWork.getImageFromJSONData(photoItemElem.url!) {(Image: UIImage) -> Void in
					self.imageView.image = Image
					dispatch_async (dispatch_get_main_queue()) {

						self.spinner.stopAnimating()
					}
				}

			}
		} // didSet {
	}

}
