//
//  SettingsViewController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 29.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var swipeGestureLeft: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupInit() {
        swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewCotroller.handleGestureLeft (_:)))
        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(self.swipeGestureLeft)
    }
    
    func handleGestureLeft(gesture: UITapGestureRecognizer) {
        navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
