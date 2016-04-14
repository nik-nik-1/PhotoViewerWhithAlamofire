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
            
            imageId?.text     = String(receivedCell!.id)
            
            JSONWork.getImageFromJSONData(receivedCell!.url) {(Image: UIImage) -> Void in
                self.imageView.image = Image
            }
        }
    }
    
}
