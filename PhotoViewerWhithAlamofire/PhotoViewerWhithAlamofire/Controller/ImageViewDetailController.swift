//
//  ImageViewDetailController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ImageViewDetailController: UIViewController {

    var receivedCell: PhotoInfo?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if receivedCell != nil {
            
            let photoId:String = String(receivedCell!.id)
            imageId?.text = photoId
            
            let Router = Router500px(imageSize: Five100px.ImageSize.Large, photoId: photoId)
            JSONWork.getImageFromJSONData(Router) {(Image: UIImage) -> Void in
                self.imageView.image = Image
            }
            
        }
    }
    
}
