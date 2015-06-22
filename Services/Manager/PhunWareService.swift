//
//  PhunService.swift
//  Phunware
//
//  Created by Jeyanthan Periyasamy on 6/20/15.
//  Copyright (c) 2015 Jeyanthan Periyasamy. All rights reserved.
//

import Foundation
@objc class PhunWareService
{
  private init()
  {
    
  }
  
  class var sharedInstance: PhunWareService  {
    struct Static {
      static var instance: PhunWareService?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = PhunWareService()
    }
    
    return Static.instance!
  }
  
  func getPhunwareDataFromService(url:NSURL,parameter:[String:AnyObject]?,completion:(data:JSON?,error:NSError?) -> ())  {
    
    var mutableURLRequest = NSMutableURLRequest.getRequestWithURL(url)
    let encoding = ParameterEncoding.URL
    (mutableURLRequest,_) = encoding.encode(mutableURLRequest,parameters: parameter)
    let manager = Manager.sharedInstance
    let url = mutableURLRequest.URLString;
    let request = manager
      .request(mutableURLRequest)
      .validate()
      .responseJSON {(request, response, jsonData, error) in
        
        var resultData:JSON!
        var responseError = error
        
        if let data: AnyObject = jsonData{
          resultData = JSON( data)
        }
        if let resultError = error {
        }
        else{
          completion(data: resultData,error: responseError)
        }
        
    }
    
  }
  
}