//
//  LeftSettingsViewController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 29.04.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class LeftSettingsViewController: UIViewController {
    
    @IBOutlet weak var settingContainer1: UIView!
    @IBOutlet weak var settingContainer2: UIView!
    private var swipeGestureLeft: UISwipeGestureRecognizer!
    var mainViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupInit() {
        let alphaChannelForSideMenu = GeneralValues.alphaChannelForSideMenu
        view.backgroundColor = view.backgroundColor!.colorWithAlphaComponent(alphaChannelForSideMenu)
//        settingContainer1.backgroundColor = settingContainer1.backgroundColor!.colorWithAlphaComponent(alphaChannelForSideMenu)
//        settingContainer2.backgroundColor = settingContainer2.backgroundColor!.colorWithAlphaComponent(alphaChannelForSideMenu)
        
//        swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ImageViewController.handleGestureLeft (_:)))
//        self.swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
//        self.view.addGestureRecognizer(self.swipeGestureLeft)
    }
    
    func handleGestureLeft(gesture: UITapGestureRecognizer) {
//        navigationController?.popViewControllerAnimated(true)
//        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
