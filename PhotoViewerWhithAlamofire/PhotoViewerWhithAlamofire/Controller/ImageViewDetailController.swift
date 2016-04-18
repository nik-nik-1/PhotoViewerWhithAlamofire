//
//  ImageViewDetailController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ImageViewDetailController: UIViewController {

    var receivedCell: PhotoInfoOM?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
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
                self.spinner.stopAnimating()
                self.scrollView.contentSize = self.imageView.frame.size
            }
            
        }
    }
}
