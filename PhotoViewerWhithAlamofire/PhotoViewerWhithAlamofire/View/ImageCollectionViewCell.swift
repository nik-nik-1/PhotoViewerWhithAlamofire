//
//  ImageCollectionViewCell.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageId: UILabel!
    
    var photoItemElem:PhotoInfo!{
        didSet {
            imageId?.text     = String(photoItemElem.id)
            
            JSONWork.getImageFromJSONData(photoItemElem.url) {(Image: UIImage) -> Void in
                dispatch_async(dispatch_get_main_queue()){
                    self.imageView.image = Image
                }
            }
            
        }
    }
    
}
