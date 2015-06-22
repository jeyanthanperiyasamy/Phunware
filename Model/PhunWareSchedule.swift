//
//  PhunSchedule.swift
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//
import Foundation
@objc class PhunWareSchedule
{
  var end_date:String?
  var start_date:String?
  private init(){
    
  }
  class func instance(fromJSON data: JSON) -> PhunWareSchedule
  {
    var instance : PhunWareSchedule = PhunWareSchedule()
    instance.start_date = data["start_date"].stringValue
    instance.end_date = data["end_date"].stringValue
    return(instance)
  }
}