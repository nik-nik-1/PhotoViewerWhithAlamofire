//
//  ImageCollectionViewCell.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//
//https://habrahabr.ru/post/320152/

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var needtoInstalImageInCell: Bool = true

    var photoItemElem: PhotoInfoOM! {
        willSet (newPhotoItemElem) {

            imageView.image = UIImage(named: "noimage.png")
        }

        didSet {
            updateUI()
        }
    }

    private func updateUI() {

        guard needtoInstalImageInCell, let url = photoItemElem.url else {
            return
        }

        spinner.startAnimating()
        JSONWork.getImageFromJSONData(url) {(Image: UIImage) -> Void in

            DispatchQueue.main.async  {
                if url == self.photoItemElem.url {
                    self.imageView.image = Image

                    self.spinner.stopAnimating()
                }
            }
        }
    }

}
