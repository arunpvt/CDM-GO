//
//  InvokeService.swift
//  CDM Go
//
//  Created by Developer on 07/09/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class InvokeService: NSObject {
static let USERNAMEJSONKEY = "UserName"
static let USEREMAILJSONKEY = "EmailAddress"
static let USERSTATUSJSONKEY = "UserStatus"
static let USERIDJSONKEY = "UserID"

static let GETMETHOD = "GET"
static let POSTMETHOD = "POST"

static let APPROVEDSTATUS = "Approved"
static let REJECTEDSTATUS = "Rejected"
    
static let GETUSERURL = "/API/Login"
static let GETPROJECTURL = "/SyncProjects"
static let NOTIFICATIONURL = "/UpdateNotification"
static let APNUPDATEURL = "/UpdateDeviceAPN"

   
static func getUser(userName : String , emailAddress : String) -> (String?, String?,Bool)
{
    var userStatus : String?
    var userId : String?
    var userDetails : NSDictionary = [USERNAMEJSONKEY : userName , USEREMAILJSONKEY : emailAddress]
    var jsonString = convertToJsonString(userDetails)
    var response = ServiceInvoker.invokeServie(GETUSERURL, method: POSTMETHOD, withObject: jsonString!,isProject: false)
    if(response.status)
    {
        let userDetailsFromService = convertJsonToDictionary(response.output!)
        println(userDetailsFromService)
        if(userDetailsFromService != nil)
        {
            var userEmailInSerice  = trimSpacesInString(userDetailsFromService?.objectForKey(InvokeService.USEREMAILJSONKEY) as? String)
       
            if (emailAddress == userEmailInSerice)
            {
                userStatus  = trimSpacesInString(userDetailsFromService?.objectForKey(InvokeService.USERSTATUSJSONKEY) as? String)
                userId = trimSpacesInString(userDetailsFromService?.objectForKey(InvokeService.USERIDJSONKEY) as? String)
            
            }
        }
        
    }
    return (userId,userStatus,response.status)
   
}

static func getProject(userID : String)->(AnyObject?,Bool)
{
    var response = ServiceInvoker.invokeServie(GETPROJECTURL, method: GETMETHOD, withObject: nil, isProject: true)
    if(response.status)
    {
        let jsonSerialize: AnyObject? =  NSJSONSerialization.JSONObjectWithData(response.output as! NSData, options: NSJSONReadingOptions(0), error: nil)
        return (jsonSerialize,response.status)
    }
    return (nil,response.status)
}
static func setProjectNotification (userID : String,projetId:String,notificationStatus:Bool)
{
    //var userDetails : NSDictionary = [USERIDJSONKEY : userID , USEREMAILJSONKEY : emailAddress]
    //var response = ServiceInvoker.invokeServie(NOTIFICATIONURL, method: GETMETHOD, withObject: <#NSString!#>, isProject: <#Bool#>)
}
static func deserializeJsonObject(anyObj: AnyObject) -> [ Project]
{
    var projectList: [ Project] = []
    
    if anyObj is Array<AnyObject> {
        for json in anyObj as! Array< AnyObject> {
            
            var project = Project()
            project.initWithDictionary (json as! [String: AnyObject] )
            projectList.append (project)
        }
    }
 return projectList
}
   
static func updateDeviceToken(deviceToken : NSString,userId : NSString) {
    
    var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
    var deviceTokenString: String = (deviceToken as NSString)
        .stringByTrimmingCharactersInSet(characterSet)
        .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
    
    var urlWithDetails = NSString(format: "%@?userID=%@&deviceAPN%@",APNUPDATEURL,userId,deviceTokenString)
    var response = ServiceInvoker.invokeServie(urlWithDetails, method: PUTMETHOD, withObject: nil, isProject: true)
        
    }
static func convertToJsonString(value : AnyObject) -> String?
{
    let bytes = NSJSONSerialization.dataWithJSONObject(value, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
    
    let stringData = NSString(data: bytes!, encoding: NSUTF8StringEncoding) as String!
    
    return stringData!
    
}
static func convertJsonToDictionary(value : AnyObject) -> NSDictionary?
{

    let dictonary = NSJSONSerialization.JSONObjectWithData(value as! NSData, options: nil, error: nil) as! Dictionary<String , String>
   
    return dictonary
    
}
static func trimSpacesInString(value :String?) ->String?
{
    var trimmedString = value?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
    return trimmedString
        
        
}
    
    
}