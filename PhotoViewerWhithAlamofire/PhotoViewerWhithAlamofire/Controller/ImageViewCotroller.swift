//
//  ImageViewCotroller.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ImageViewCotroller: UIViewController {
    
    var photos = NSMutableOrderedSet(){
        didSet {
            collectionView.photos = photos
            collectionView.reloadData()
        }
    }
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let gridFlowLayout = ImageGridFlowLayout()
    
    
    
    @IBOutlet weak var collectionView: ImageCollectionView!
    @IBAction func refreshImageData(sender: AnyObject) {
        
        JSONWork.getJSONDataFromURl() {(photoInfos) -> Void in
            self.photos.addObjectsFromArray(photoInfos)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView.delegate = self;
        setupInit()
        
        view.addSubview(spinner)
        
    }
    
    func setupInit() {
        collectionView.collectionViewLayout = gridFlowLayout
        
        spinner.center = CGPoint(x: view.center.x, y: view.center.y - view.bounds.origin.y / 2.0)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
}
