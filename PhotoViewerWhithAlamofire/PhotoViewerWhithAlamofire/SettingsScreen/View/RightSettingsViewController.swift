//
//  RightSettingsViewController.swift
//  PhotoViewerWhithAlamofire
//
//  Created by mc373 on 11.05.16.
//  Copyright © 2016 mc373. All rights reserved.
//

import UIKit

class RightSettingsViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		// swiftlint:disable:next line_length
		view.backgroundColor = view.backgroundColor!.withAlphaComponent(GeneralValues.alphaChannelForSideMenu)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a
	//little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/

}
