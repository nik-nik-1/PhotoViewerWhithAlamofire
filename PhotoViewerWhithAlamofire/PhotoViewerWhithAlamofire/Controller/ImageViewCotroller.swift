//
//  ImageViewController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

/// Notification when new photo instances are added
let photoMAddedContentNotification = "test.PhotoViewerWhithAlamofire"

class ImageViewController: UIViewController, workWhithControllerViewFromImageCollectionView {

	var currentPage: Int = 0 {
		didSet {
			GeneralValues.pageToLoad = self.currentPage
		}
	}
	var populatingPhotos: Bool = false
	var recivedCellFromImageViewController: PhotoInfoOM?

	fileprivate var addedContentObserver: NSObjectProtocol!

	fileprivate var photosInstance: [PhotoInfoOM] {
		get {return collectionView.photos}

		set {collectionView.photos = newValue
			showOrHideNavPrompt()}
	}

	var photos: [PhotoInfoOM] {
		get {
			var photosCopy: [PhotoInfoOM]!
			concurrentPhotoQueue.sync { // 1
				photosCopy = self.photosInstance // 2
			}
			return photosCopy
		}
		set (newValue) {
			//            dispatch_barrier_async(concurrentPhotoQueue) {
			self.photosInstance = newValue
			//                dispatch_async(globalMainQueue) { // 3
			//                    self.postContentAddedNotification()
			//                }
			//            }
		}
	}

	// swiftlint:disable line_length
	fileprivate let concurrentPhotoQueue = DispatchQueue(label: "test.PhotoViewerWhithAlamofire.photoQueue", attributes: DispatchQueue.Attributes.concurrent)
	// swiftlint:enable line_length

	fileprivate var tapPressGesture: UITapGestureRecognizer!

	// create swipe gesture
	fileprivate var swipeGestureLeft: UISwipeGestureRecognizer!
	fileprivate var swipeGestureRight: UISwipeGestureRecognizer!

	@IBOutlet weak var spinner: UIActivityIndicatorView!

	let gridFlowLayout = ImageGridFlowLayout()

	@IBOutlet weak var collectionView: ImageCollectionView!

	@IBAction func refreshImageData(_ sender: AnyObject) {
		refreshImageData ()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		collectionView.controllerDelegate = self

		setupInit()
		refreshImageData()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.setNavigationBarItem()

		self.slideMenuController()?.closeLeft()
	}

	override func viewDidAppear(_ animated: Bool) {
		showOrHideNavPrompt()
	}

	deinit {
		let nc = NotificationCenter.default

		if addedContentObserver != nil {
			nc.removeObserver(addedContentObserver)
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if segue.identifier == "imageDetailShow" {
			// not work already but!-> it can be useful in the future
			let detailViewController = segue.destination as? ImageViewDetailController

			detailViewController!.receivedCell = recivedCellFromImageViewController
			//            detailViewController.detailDelegate = self
		} else
			if segue.identifier == "showPhotoPage" {
				let managePageViewController = segue.destination as? ManagePageViewController

				managePageViewController!.photos = photos
				managePageViewController!.receivedCell = recivedCellFromImageViewController
		}
	}

	//MARK: Delgate: workWhithControllerViewFromImageCollectionView
	func setCorrectActiveCellInView(_ activeItem: PhotoInfoOM?) {
		recivedCellFromImageViewController = activeItem
	}

	func getMorePhoto (_ scrollView: UIScrollView) {
		if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.8 {
			getMorePhotoFromURL()
		}
	}

	fileprivate func refreshImageData () {
		currentPage = 0
		photos = []
		getMorePhotoFromURL()
	}

	func getMorePhotoFromURL() {

		if populatingPhotos {
			return
		}
		populatingPhotos = true

		spinner.startAnimating()

		concurrentPhotoQueue.async(flags: .barrier, execute: {

			let Router = Router500px(imageSize: Five100px.ImageSize.tiny)
			JSONWork.getJSONDataFromURl(Router) {(photoInfos) -> Void in

				self.addNewPhotoToArray (photoInfos)

			}
		}) 

	}

	fileprivate func addNewPhotoToArray (_ photoInfos: [PhotoInfoOM]) {

		//        dispatch_barrier_async(concurrentPhotoQueue) {
		let lastItem = self.photos.count

		self.collectionView.updateCollectionWhenAddednewElement = false
		self.photos += photoInfos

		for index in lastItem...self.photos.count-1 {
			self.photos[index].photoIndex = index
		}


		self.collectionView.updateCollectionWhenAddednewElement = true

		let indexPaths = (lastItem..<self.photos.count).map { IndexPath(item: $0, section: 0) }

		globalMainQueue.async {
			//self.collectionView!.insertItemsAtIndexPaths(indexPaths)

			if lastItem == 0 {
				self.collectionView.reloadData()
			} else {
				self.collectionView!.insertItems(at: indexPaths)
			}

			self.spinner.stopAnimating()
			self.currentPage += 1

			//                self.postContentAddedNotification()
			self.populatingPhotos = false
		}
	}

}


extension ImageViewController {

	//MARK: Init. help func
	func setupInit() {
		// swiftlint:disable line_length
		currentPage = 0

		collectionView.collectionViewLayout = gridFlowLayout

		tapPressGesture = UITapGestureRecognizer(target: self, action: #selector(ImageViewController.handleTapGesture(_:)))

		tapPressGesture.cancelsTouchesInView = false
		self.collectionView.addGestureRecognizer(tapPressGesture)


		//        swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.handleGestureLeft(_:)))
		//        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
		//        self.view.addGestureRecognizer(self.swipeGestureLeft)
		//
		//        swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.handleGestureRight (_:)))
		//        self.swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
		//        self.view.addGestureRecognizer(self.swipeGestureRight)


		addedContentObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: photoMAddedContentNotification),
		                                                                               object: nil,
		                                                                               queue: OperationQueue.main) { notification in
																																										self.contentChangedNotification(notification)

		}
		// swiftlint:enable line_length
	}


	//MARK: GCD
	func contentChangedNotification(_ notification: Notification!) {
		collectionView?.reloadData()
		showOrHideNavPrompt()
	}

	func showOrHideNavPrompt() {
		// Implement me!
		let delayInSeconds = 2.0
		let popTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC) // 1
		globalMainQueue.asyncAfter(deadline: popTime) { // 2
			let count = self.photos.count
			if count > 0 {
				self.navigationItem.prompt = nil
			} else {
				self.navigationItem.prompt = "Tap \"Update button\" to update photos"
			}
		}
	}


	//Gesture
	func handleTapGesture(_ gesture: UITapGestureRecognizer) {

		switch gesture.state {
		case UIGestureRecognizerState.ended:
			let gLoc = gesture.location(in: self.collectionView)
			guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gLoc) else {
				break
			}

			setCorrectActiveCellInView(photos[selectedIndexPath.row])

		case UIGestureRecognizerState.began: break
		default: break

		}
	}

	func handleGestureLeft(_ gesture: UITapGestureRecognizer) {
		//navigationController?.popViewControllerAnimated(true)

	}

	func handleGestureRight(_ gesture: UITapGestureRecognizer) {
		// swiftlint:disable line_length
		//        let LeftSettingsViewController = storyboard!.instantiateViewControllerWithIdentifier("LeftViewController")
		//        LeftSettingsViewController.modalPresentationStyle = .FormSheet
		////        self.presentViewController(settingsViewController, animated: true, completion: nil)
		//
		//        self.navigationController?.pushViewController(LeftSettingsViewController, animated: true)
		// swiftlint:enable line_length
	}

}

extension ImageViewController : SlideMenuControllerDelegate {

	func leftWillOpen() {
		print("SlideMenuControllerDelegate: leftWillOpen")
	}

	func leftDidOpen() {
		print("SlideMenuControllerDelegate: leftDidOpen")
	}

	func leftWillClose() {
		print("SlideMenuControllerDelegate: leftWillClose")
	}

	func leftDidClose() {
		print("SlideMenuControllerDelegate: leftDidClose")
	}

	func rightWillOpen() {
		print("SlideMenuControllerDelegate: rightWillOpen")
	}

	func rightDidOpen() {
		print("SlideMenuControllerDelegate: rightDidOpen")
	}

	func rightWillClose() {
		print("SlideMenuControllerDelegate: rightWillClose")
	}

	func rightDidClose() {
		print("SlideMenuControllerDelegate: rightDidClose")
	}
}
