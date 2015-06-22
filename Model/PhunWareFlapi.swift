//
//  PhunFlapi.swift
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//

import Foundation
@objc class PhunWareFlapi
{
  var zip:Int?
  var phone:String?
  var ticket_link:String?
  var state:String?
  var pcode:Int?
  var city:String?
  var id:Int?
  var tollfreephone:String?
  var schedule:[PhunWareSchedule]? = [PhunWareSchedule]()
  var address:String?
  var image_url:String?
  var description:String?
  var name:String?
  var longitude:Double?
  var latitude:Double?
  
  private init(){
    
  }
  
  class func instance(fromJSON data: JSON) -> PhunWareFlapi
  {
    var instance : PhunWareFlapi = PhunWareFlapi()
    let schedules = data["schedule"].arrayValue
    for schedule in schedules {
      instance.schedule?.append(PhunWareSchedule.instance(fromJSON: schedule))
    }
    instance.zip = data["zip"].intValue
    instance.id = data["id"].intValue
    instance.pcode = data["pcode"].intValue
    instance.phone = data["phone"].stringValue
    instance.ticket_link = data["ticket_link"].stringValue
    instance.state = data["state"].stringValue
    instance.city = data["city"].stringValue
    instance.tollfreephone = data["tollfreephone"].stringValue
    instance.image_url = data["image_url"].stringValue
    instance.address = data["address"].stringValue
    instance.description = data["description"].stringValue
    instance.name = data["name"].stringValue
    instance.longitude = data["longitude"].doubleValue
    instance.latitude = data["latitude"].doubleValue
    
    return(instance)
  }
}