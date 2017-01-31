//
//  Utils.swift
//  GooglyPuff
//
//  Created by Bjørn Olav Ruud on 07.08.14.
//  Copyright (c) 2014 raywenderlich.com. All rights reserved.
//

import Foundation
import UIKit

var globalMainQueue: DispatchQueue {
  return DispatchQueue.main
}

var globalUserInteractiveQueue: DispatchQueue {
  return DispatchQueue.global(qos: .userInteractive)
}

var globalUserInitiatedQueue: DispatchQueue {
  return DispatchQueue.global(qos: .userInitiated)
}

var globalUtilityQueue: DispatchQueue {
  return DispatchQueue.global(qos: .utility)
}

var globalBackgroundQueue: DispatchQueue {
  return DispatchQueue.global(qos: .background)
}


class Utils {
  class var defaultBackgroundColor: UIColor {
    return UIColor(red: 236.0/255.0, green: 254.0/255.0, blue: 255.0/255.0, alpha: 1.0)
  }

  class var userInterfaceIdiomIsPad: Bool {
    return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
  }
}
