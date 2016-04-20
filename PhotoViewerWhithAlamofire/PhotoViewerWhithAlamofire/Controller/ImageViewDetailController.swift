//
//  ImageViewDetailController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//
//see also: https://www.raywenderlich.com/122139/uiscrollview-tutorial

import UIKit

class ImageViewDetailController: UIViewController {

    var receivedCell: PhotoInfoOM?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewCenterYConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageId: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
   
        //super.viewDidAppear()
        
        if receivedCell != nil {
            
            var photoId:String = "" //= String(receivedCell!.id)
            if let tempPhotoId = receivedCell!.id {
                photoId = String(tempPhotoId)
            }
            
            imageId?.text = photoId
            
            let Router = Router500px(imageSize: Five100px.ImageSize.Large, photoId: photoId)
            JSONWork.getImageFromJSONData(Router) {(Image: UIImage) -> Void in
                self.imageView.image = Image
                self.imageView.frame = CGRect(x: 0, y: 0, width: Image.size.height, height: Image.size.width)
                self.imageView.sizeToFit()
                self.scrollView.contentSize = self.imageView.frame.size
                            
                self.spinner.stopAnimating()
            }
            
        }
    }
}


//MARK: extension
extension ImageViewDetailController: UIScrollViewDelegate {
    //MARK: native func, e.t. bonus
    private func updateMinZoomScaleForSize(size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        
        scrollView.zoomScale = minScale
    }
   
    private func updateConstraintsForSize(size: CGSize) {
        
//        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
//        
//        imageViewTopConstraint.constant = yOffset
//        imageViewBottomConstraint.constant = yOffset
//
//        
//        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
// 
//        imageViewLeadingConstraint.constant = xOffset
//        imageViewTrailingConstraint.constant = xOffset
//
//        
//        view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    //MARK: UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
}
