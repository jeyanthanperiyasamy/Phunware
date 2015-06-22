//
//  OSTKDeliveryResponse.swift
//  Overstock
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 overstock.com. All rights reserved.
//

import Foundation
@objc class PhunwareResult
{
  var phunwareDataList:[PhunWareFlapi]? = [PhunWareFlapi]()
  private init(){
    
  }
  
  class func instance(fromJson data:JSON) -> PhunwareResult {
    var instance = PhunwareResult()
    let shipOptions = data.arrayValue
    for shipOption in shipOptions {
      instance.phunwareDataList?.append(PhunWareFlapi.instance(fromJSON: shipOption))
    }
       return instance
  }
}