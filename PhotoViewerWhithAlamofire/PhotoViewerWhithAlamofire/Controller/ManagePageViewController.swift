//
//  ManagePageViewController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 20.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController {
    
    weak var pageControl: UIPageControl!
    var currentIndex: Int!
    var receivedCell: PhotoInfoOM! {
        didSet {
            currentIndex = GeneralFunctions.getPhotoIndexFromItemElement(receivedCell)
        }
    }
    var photos:[PhotoInfoOM] = []
    let maxViewPagesOnUIPageControl: Int = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        pageControl.numberOfPages = maxViewPagesOnUIPageControl
        //        pageControl.
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
        
        pageControl.currentPage = { ()-> Int in
            var valueToReturn: Int = 0
            
            if currentIndex != nil && currentIndex > 0 && photos.count > maxViewPagesOnUIPageControl {
                valueToReturn = max(0,(currentIndex/(photos.count/maxViewPagesOnUIPageControl)) - 1)
            } else {
                valueToReturn = currentIndex
            }
            
//            print("value = ", valueToReturn)
            
            return valueToReturn
        }();
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
        }
        return nil
    }
    
    // MARK: UIPageControl
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0//photos.count//maxViewPagesOnUIPageControl//max(maxViewPagesOnUIPageControl, photos.count)
        
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageControl.currentPage//currentIndex ?? 0
       
    }
    
}