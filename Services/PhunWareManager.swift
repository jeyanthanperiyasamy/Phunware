//
//  PhunManager.swift
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//

import Foundation

@objc class PhunWareManager
{
  
  private init()
  {
    
  }
  
  class var sharedInstance: PhunWareManager  {
    struct Static {
      static var instance: PhunWareManager?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = PhunWareManager()
    }
    
    return Static.instance!
  }
  
  func getPhunWareData(completion:(result:PhunwareResult?,error:NSError?) -> ()){
    var returnData:PhunwareResult?
    var returnError:NSError?
    PhunWareService.sharedInstance.getPhunwareDataFromService(NSURL(string:"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json")!, parameter:nil, completion: {(data:JSON?,error:NSError?) -> () in
      returnError = error
      if let data = data{
        returnData = PhunwareResult.instance(fromJson: data)
      }
      completion(result: returnData, error: returnError)
      
    })
    
    
  }
  
}