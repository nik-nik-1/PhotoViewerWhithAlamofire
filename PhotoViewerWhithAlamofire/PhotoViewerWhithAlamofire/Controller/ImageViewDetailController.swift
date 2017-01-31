//
//  ImageViewDetailController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//
//see also: https://www.raywenderlich.com/122139/uiscrollview-tutorial

import UIKit

protocol SetViewParametersOnPageManager {
	func setViewParametresOfNavigationItem (_ title: String!)
}

class ImageViewDetailController: UIViewController {

	var receivedCell: PhotoInfoOM?
	var photoIndex: Int? {
		get {
			return GeneralFunctions.getPhotoIndexFromItemElement(receivedCell)
		}
	}

	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var scrollView: UIScrollView! {
		didSet {
			scrollView.contentSize = imageView.frame.size
		}
	}

	@IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!

	//@IBOutlet weak var imageId: UILabel!
	var imageIdStr: String {
		get {
			var photoId: String = ""
			if receivedCell != nil {

				if let tempPhotoId = receivedCell!.id {
					photoId = String(tempPhotoId)
				}
			}
			return photoId
		}
	}

	@IBOutlet weak var spinner: UIActivityIndicatorView!

	fileprivate var image: UIImage? {
		get {return imageView.image}
		set {
			imageView.image = newValue
			imageView.sizeToFit()
			scrollView?.contentSize = imageView.frame.size

			if spinner.isAnimating {
				spinner.stopAnimating()
			}
		}
	}

	var managerPageControllerDelegate: SetViewParametersOnPageManager?

	override func viewDidLoad() {
		super.viewDidLoad()

		spinner.startAnimating()

		scrollView.addSubview(imageView)
	}


	override func viewDidAppear(_ animated: Bool) {

		navigationItem.title = "ID: "+imageIdStr

		if receivedCell != nil {

			globalUserInitiatedQueue.async { // 1

				let router = Router500px(imageSize: Five100px.ImageSize.large, photoId: self.imageIdStr)
				JSONWork.getImageFromJSONData(router) {(Image: UIImage) -> Void in

					globalMainQueue.async { // 2
						self.image = Image

					}
				}
			}
		}

		managerPageControllerDelegate?.setViewParametresOfNavigationItem(navigationItem.title)
	}
}


//MARK: extension
extension ImageViewDetailController: UIScrollViewDelegate {
	//MARK: native func, e.t. bonus
	fileprivate func updateMinZoomScaleForSize(_ size: CGSize) {
		let widthScale = size.width / imageView.bounds.width
		let heightScale = size.height / imageView.bounds.height
		let minScale = min(widthScale, heightScale)

		scrollView.minimumZoomScale = minScale

		scrollView.zoomScale = minScale
	}

	fileprivate func updateConstraintsForSize(_ size: CGSize) {

		let mSize = (size.height - imageView.frame.height) / 2.5
		let yOffset = max(0, mSize) // 2.5 = little upper then center of view

		imageViewTopConstraint.constant = yOffset
		imageViewBottomConstraint.constant = yOffset


		let xOffset = max(0, (size.width - imageView.frame.width) / 2.5)

		imageViewLeadingConstraint.constant = xOffset
		imageViewTrailingConstraint.constant = xOffset

		view.layoutIfNeeded()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		updateMinZoomScaleForSize(view.bounds.size)
	}

	//MARK: UIScrollViewDelegate
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}

	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		updateConstraintsForSize(view.bounds.size)
	}

}
