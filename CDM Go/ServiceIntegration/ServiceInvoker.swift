//
//  ServiceInvoker.swift
//  CDM Go Admin
//
//  Created by Developer on 05/09/15.
//  Copyright (c) 2015 Developer. All rights reserved.
//

import Foundation
import UIKit





let GETMETHOD = "GET"
let POSTMETHOD = "POST"
let PUTMETHOD = "PUT"
let DELETEMETHOD = "DELETE"

let SERVER1URL = "http://192.168.20.117:80/CDMGoAdminService"
let SERVER2URL = "http://192.168.20.117:80/CDMGoProjectService"



class ServiceInvoker: NSObject{
    
    static func setCulture(urlRequest: NSMutableURLRequest)-> NSMutableURLRequest{
        var culture = NSLocale.preferredLanguages()
        urlRequest.setValue(culture[0] as? String, forHTTPHeaderField: "CultureName")
        return urlRequest
    }
    
    static func setLoggingHeader (urlRequest: NSMutableURLRequest) ->NSMutableURLRequest{
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var deviceToken = delegate.deviceToken
        //var deviceToken: String = "12345678910"
        if((deviceToken) == nil){
            deviceToken = "12345678910"
        }
        
        var deviceOSName = UIDevice.currentDevice().systemName
        var deviceOSVersion = UIDevice.currentDevice().systemVersion
        var deviceOS = NSString(format: "%@ %@", deviceOSName, deviceOSVersion)
        var deviceType = UIDevice.currentDevice().model
        urlRequest.setValue(deviceToken, forHTTPHeaderField: "NotificationId")
        urlRequest.setValue(deviceOS as String, forHTTPHeaderField: "DeviceOS")
        urlRequest.setValue(deviceType, forHTTPHeaderField: "DeviceType")
        
        
        return urlRequest
    }
    
    static func constructURLRequest(service: NSString, method methodType: NSString, input: NSString!,serverURL :NSString) -> NSMutableURLRequest{
        var urlString = NSString(format:"%@%@", serverURL, service);
        var url = NSURL(string: urlString as String);
        
        var urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        
        urlRequest.HTTPMethod = methodType as String
        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "content-type");
        if(urlString.lastPathComponent.hasPrefix("GetAuthenticated")){
            urlRequest = setLoggingHeader(urlRequest);
            urlRequest = setCulture(urlRequest);
        }
            if(input != nil){
                var objData = input.dataUsingEncoding(NSUTF8StringEncoding)
                urlRequest.HTTPBody = objData
            }
                return urlRequest
        
    }

    static  func invokeServie(service: NSString, method methodType: NSString, withObject obj: NSString! ,isProject : Bool) -> ServiceResponse {
    
    let serverUrl = isProject ? SERVER2URL : SERVER1URL;
    var urlRequest: NSURLRequest = self.constructURLRequest(service, method: methodType, input: obj,serverURL: serverUrl)
    var urlResponse: NSURLResponse?
    var error: NSError?
    let responseData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: &urlResponse, error:  &error)
    let httpURLResponse = urlResponse as? NSHTTPURLResponse
    //let responseString: NSString? = NSString(data: responseData!, encoding: NSUTF8StringEncoding)
    
    if (httpURLResponse?.statusCode == 200 || httpURLResponse?.statusCode == 204)
    {
        let serviceResponse = ServiceResponse(status: true, opt: responseData!, err: nil)
        //println(responseString)
        return serviceResponse;
    }
    if (httpURLResponse?.statusCode == 400 || httpURLResponse?.statusCode == 0)
    {
        let serviceResponse = ServiceResponse(status: false, opt: nil, err: nil)
        
        return serviceResponse
    }
    
    return ServiceResponse(status: false, opt: nil, err: nil);
    
    
    }
   
    
}