//
//  ImageView.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 13.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

protocol workWhithControllerViewFromImageCollectionView {
    
    func setCorrectActiveCellInView(activeItem:PhotoInfoOM?)
    func getMorePhoto(scrollView:UIScrollView)
    
}

class ImageCollectionView: UICollectionView , UICollectionViewDataSource, UICollectionViewDelegate{

    var photos: [PhotoInfoOM] = [] {//= NSMutableOrderedSet(){
        willSet (newItems){
           
        }
        didSet {
            
            if self.updateCollectionWhenAddednewElement {
                self.reloadData()
            }
        }
    }

    
    var updateCollectionWhenAddednewElement:Bool = true
    var controllerDelegate: workWhithControllerViewFromImageCollectionView?;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate   = self
    }
    
 
    //MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        //cell.delegate = self
        
        let imageItemCell = cell //as! ImageCollectionViewCell
//        let photoItemElem = photos[indexPath.row]
//        
////        if photoItemElem.photoIndex != nil && photoItemElem.photoIndex != indexPath.row {
////            print("Errror !!!! ")
////        }
//        
//        photoItemElem.photoIndex = indexPath.row
        //imageItemCell.photoItemElem = photoItemElem
        
        let massPhotoItemElem = photos.filter( { return $0.photoIndex == indexPath.row })
        if massPhotoItemElem.count > 0 {
            imageItemCell.photoItemElem = massPhotoItemElem[0]
        
        } else if massPhotoItemElem.count > 1 {
                
             print("Errror !!!! ")
        }
        

        return cell
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        performSegueWithIdentifier("ShowPhoto", sender: (self.photos.objectAtIndex(indexPath.item) as! PhotoInfo).id)
        
        //controllerDelegate?.setCorrectActiveCellInView(photos[indexPath.row]) //NOT Work good! get start behind the PrepareForSeguei - but needed to be first
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        controllerDelegate?.getMorePhoto(scrollView)
        }
    
}
