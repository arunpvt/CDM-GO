//
//  Project.swift
//  CDM Go
//
//  Created by Developer on 28/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import Foundation

class Project: AutoCoded {
    var projectId : Int
    var name : String?
    var status : ProjectStatus?
    var sprintNo : Int!
    var totalSprint : Int!
    var nextReleaseDate : String!
    var importantItem : [String]?
    var featuresCompleted : [String]?
    var buildStatus : String?
    var apnsStatus : Bool?
    
    init(projectId id :Int, projectName name:String?) {
        self.projectId = id
        self.name = name
    }
    
    enum ProjectStatus : String{
    case Normal = "Normal"
    case Moderate = "Moderate"
    case Critical = "Critical"
    }
}
