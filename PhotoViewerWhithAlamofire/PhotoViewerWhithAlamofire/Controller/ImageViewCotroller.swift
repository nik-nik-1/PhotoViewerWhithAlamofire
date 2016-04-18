//
//  ImageViewCotroller.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ImageViewCotroller: UIViewController, workWhithControllerViewFromImageCollectionView {
    
    var currentPage:Int = 0{
        didSet {
            GeneralValues.pageToLoad = self.currentPage
        }
    }
    var populatingPhotos: Bool = false
    var recivedCellFromImageViewCotroller:PhotoInfoOM?
    
    var photos:[PhotoInfoOM] = []{//[NSOrderedSet] = []{
        didSet {
            
            collectionView.photos = photos
        }
    }
    
    private var tapPressGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    //    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let gridFlowLayout = ImageGridFlowLayout()
    
    
    @IBOutlet weak var collectionView: ImageCollectionView!
    @IBAction func refreshImageData(sender: AnyObject) {
        refreshImageData ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.controllerDelegate = self;
        
        setupInit()
        //        view.addSubview(spinner)
        refreshImageData()
    }
    
    func setupInit() {
        currentPage = 0
        
        collectionView.collectionViewLayout = gridFlowLayout
        
        //        spinner.center = CGPoint(x: view.center.x, y: view.center.y - view.bounds.origin.y / 2.0)
        //        spinner.hidesWhenStopped = true
        
        tapPressGesture = UITapGestureRecognizer(target: self, action: #selector(ImageViewCotroller.handleTapGesture(_:)))
        tapPressGesture.cancelsTouchesInView = false;
        self.collectionView.addGestureRecognizer(tapPressGesture)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "imageDetailShow" {
            let detailViewController = segue.destinationViewController as! ImageViewDetailController
            
            detailViewController.receivedCell = recivedCellFromImageViewCotroller
            //            detailViewController.detailDelegate = self
        }
    }
    
    //MARK: Delgate: workWhithControllerViewFromImageCollectionView
    func setCorrectActiveCellInView(activeItem: PhotoInfoOM?) {
        recivedCellFromImageViewCotroller = activeItem
    }
    
    func getMorePhoto (scrollView:UIScrollView){
        if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.8 {
            getMorePhotoFromURL()
        }
    }
    
    func refreshImageData () {
        
        
        if populatingPhotos {
            return
        }
        populatingPhotos = true
        
        currentPage = 0
        
        spinner.startAnimating()
        
        let Router = Router500px(imageSize: Five100px.ImageSize.Tiny)
        JSONWork.getJSONDataFromURl(Router) {(photoInfos) -> Void in
            
            //self.photos.addObjectsFromArray(photoInfos)
            self.photos = photoInfos
            dispatch_async(dispatch_get_main_queue()) {
                
                self.collectionView.reloadData()
                self.spinner.stopAnimating()
                
                self.currentPage += 1
            }
            self.populatingPhotos = false
        }
        
    }
    
    func getMorePhotoFromURL(){
        
        if populatingPhotos {
            return
        }
        populatingPhotos = true
        
        spinner.startAnimating()
        
        let Router = Router500px(imageSize: Five100px.ImageSize.Tiny)
        JSONWork.getJSONDataFromURl(Router) {(photoInfos) -> Void in
            
            let lastItem = self.photos.count
            
            self.collectionView.updateCollectionWhenAddednewElement = false
            self.photos += photoInfos
            self.collectionView.updateCollectionWhenAddednewElement = true
            
            let indexPaths = (lastItem..<self.photos.count).map { NSIndexPath(forItem: $0, inSection: 0) }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.collectionView!.insertItemsAtIndexPaths(indexPaths)
                self.spinner.stopAnimating()
            }
            self.currentPage += 1
            self.populatingPhotos = false
        }
//        populatingPhotos = false
    }
}

extension ImageViewCotroller{
    
    //Gesture
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.Ended:
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                break
            }
            
            setCorrectActiveCellInView(photos[selectedIndexPath.row])
            
        case UIGestureRecognizerState.Began: break
        default: break
            
        }
    }
    
    
    
}