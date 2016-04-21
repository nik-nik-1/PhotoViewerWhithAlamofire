//
//  ManagePageViewController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 20.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {

    var currentIndex: Int!
    var receivedCell: PhotoInfoOM! {
        didSet {
            currentIndex = GeneralFunctions.getPhotoIndexFromItemElement(receivedCell)
        }
    }
    var photos:[PhotoInfoOM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        // 1
        
        if let viewController = viewPhotoDetailController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            
            // 2
            setViewControllers(
                viewControllers,
                direction: .Forward,
                animated: false,
                completion: nil
            )
        }
    }
    
    override func viewWillAppear(animated: Bool) {
//        navigationItem.title = "ID: " + imageIdStr
    }
    
    func viewPhotoDetailController(index: Int) -> ImageViewDetailController? {
        if let storyboard = storyboard,
            page = storyboard.instantiateViewControllerWithIdentifier("ImageViewDetailController")
                as? ImageViewDetailController {
            
//            page.photoName = photos[index]
            page.receivedCell =  photos[index] as PhotoInfoOM
           
            page.managerPageControllerDelegate = self
            
            return page
        }
        return nil
    }
}

//MARK: protocol SetViewParametersOnPageManager
extension ManagePageViewController: SetViewParametersOnPageManager{
    
    func setViewParametresOfNavigationItem (title: String!) {
        navigationItem.title = title ?? ""
    }
}

//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController: UIPageViewControllerDataSource {
    // 1
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ImageViewDetailController {
            var index = viewController.photoIndex
            guard index != NSNotFound && index != 0 else { return nil }
            index = index! - 1
            return viewPhotoDetailController(index!)
//            return viewPhotoDetailController(viewController.receivedCell!)
        }
        return nil
    }
    
    // 2
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? ImageViewDetailController {
            var index = viewController.photoIndex
            guard index != NSNotFound else { return nil }
            index = index! + 1
            guard index != photos.count else {return nil}
            return viewPhotoDetailController(index!)
//            return viewPhotoDetailController(viewController.receivedCell!)
        }
        return nil
    }
}