//
//  Project.swift
//  CDM Go
//
//  Created by Developer on 28/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import Foundation


class Project {
    
    var projectID : String!
    var projectName : String!
    var projectStatus : String!
    var currentSprint : Int!
    var totalSprint : Int!
    var nextReleaseDate : String!
    var keyPoints : [String]!
    var featuresCompleted : [String]!
    var featuresPending : [String]!
    var risks : [String]!
    
    
    
    func convertToJson() -> [String: AnyObject!] {
        
        return [
            "ProjectName": self.projectName,
            "ProjectStatus": self.projectStatus,
            "CurrentSprint": self.currentSprint,
            "TotalSprint": self.totalSprint,
            "NextReleaseDate": self.nextReleaseDate,
            "KeyPoints": self.keyPoints as [String],
            "FeaturesCompleted" : self.featuresCompleted as [String],
            "FeaturesPending": self.featuresPending as [String ],
            "Risks": self.risks as [String]]
    }
    
    func initWithDictionary(objDict:[String: AnyObject]) -> Project {
        
        self.projectID = objDict[ "ProjectID"] as! String;
        self.projectName = objDict[ "ProjectName"] as! String;
        self.currentSprint = objDict[ "CurrentSprint"] as! Int;
        self.totalSprint = objDict[ "TotalSprint"] as! Int;
        self.nextReleaseDate = objDict[ "NextReleaseDate"] as? String;
        self.keyPoints = objDict[ "KeyPoints"] as! [String];
        self.featuresCompleted = objDict[ "FeaturesCompleted"] as! [String];
        self.featuresPending = objDict[ "FeaturesPending"] as! [String];
        self.risks = objDict["Risks" ] as! [String];
        self.projectStatus = (objDict["ProjectStatus"] as! String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return self ;
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
}
