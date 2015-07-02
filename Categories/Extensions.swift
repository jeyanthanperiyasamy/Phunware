//
//  Extensions.swift
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy . All rights reserved.
//

import Foundation
import UIKit

let iOS8 = floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_1)
let IS_IPAD = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
let IS_IPHONE = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
extension NSMutableURLRequest {
  
  class func getRequestWithURL(url:NSURL) -> NSURLRequest
  {
    var request = NSMutableURLRequest(URL: url)
    request.HTTPMethod = "GET"
    return request.copy() as! NSURLRequest
  }
}

extension UIDevice{
  /**
  Check if device is iPhone or not
  
  :returns: true if device is iPhone
  */
  class func isiPhone() -> Bool{
    return IS_IPHONE
  }
  
  /**
  Check if device is iPad or not
  
  :returns: true of device is iPad
  */
  class func isiPad() -> Bool{
    return IS_IPAD
  }
  
}




