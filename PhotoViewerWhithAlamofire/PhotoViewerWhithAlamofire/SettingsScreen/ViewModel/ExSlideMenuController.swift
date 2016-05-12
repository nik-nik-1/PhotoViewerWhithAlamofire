//
//  ExSlideMenuController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/11/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ExSlideMenuController : SlideMenuController {

    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is ImageViewController//MainViewController
            //||
//            vc is SwiftViewController ||
//            vc is JavaViewController ||
//            vc is GoViewController 
            {
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
//        SlideMenuOptions.leftViewWidth = 300
//        SlideMenuOptions.contentViewScale = 0.50
        
//        SlideMenuOptions.leftViewWidth = 300.0
 //       SlideMenuOptions.leftBezelWidth = 200.0
//        SlideMenuOptions.contentViewScale = 0.96
//        SlideMenuOptions.contentViewOpacity = 0.9
//        SlideMenuOptions.shadowOpacity = 4.4
//        SlideMenuOptions.shadowRadius = 45.5
//        SlideMenuOptions.shadowOffset = CGSizeMake(2,0)
 //       SlideMenuOptions.panFromBezel = false
 //       SlideMenuOptions.animationDuration = 1.4
//        SlideMenuOptions.rightViewWidth = 270.0
//        SlideMenuOptions.rightBezelWidth = 16.0
//        SlideMenuOptions.rightPanFromBezel = true
//        SlideMenuOptions.hideStatusBar = true
//        SlideMenuOptions.pointOfNoReturnWidth = 44.0
//        SlideMenuOptions.simultaneousGestureRecognizers = true
        //  SlideMenuOptions.opacityViewBackgroundColor = UIColor.redColor()
    }
    
    
    override func track(trackAction: TrackAction) {
        switch trackAction {
        case .LeftTapOpen:
            print("TrackAction: left tap open.")
        case .LeftTapClose:
            print("TrackAction: left tap close.")
        case .LeftFlickOpen:
            print("TrackAction: left flick open.")
        case .LeftFlickClose:
            print("TrackAction: left flick close.")
        case .RightTapOpen:
            print("TrackAction: right tap open.")
        case .RightTapClose:
            print("TrackAction: right tap close.")
        case .RightFlickOpen:
            print("TrackAction: right flick open.")
        case .RightFlickClose:
            print("TrackAction: right flick close.")
        }   
    }
}
