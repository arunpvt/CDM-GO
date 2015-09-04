//
//  InterfaceController.swift
//  CDM Go WatchKit Extension
//
//  Created by Developer on 27/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var projectTable: WKInterfaceTable!
    var projectsModel : [Project]!
    let projects = ["CDM","Driver Seat","Tymetrix"]
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        projectsModel = sampleData()
        loadTableRows()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func loadTableRows()
    {
        projectTable.setNumberOfRows(projectsModel.count, withRowType: "projectTableRow")
       
        var i : Int = 0
        for project in projectsModel
        {
            let row = projectTable.rowControllerAtIndex(i) as! ProjectTableRow
            
            row.projectName.setText(project.name)
            if(project.status == Project.ProjectStatus.Critical)
            {
                row.projectAlertImageView.setImageNamed("High Priority-50.png")
            }
            else if(project.status == Project.ProjectStatus.Moderate)
            {
                row.projectAlertImageView.setImageNamed("Medium Priority-50")
            }
            else if(project.status == Project.ProjectStatus.Normal)
            {
                
                row.projectAlertImageView.setImageNamed("Low Priority-50")
            }
            row.projectNextReleaseDate.setText(project.nextReleaseDate)
            ++i
        }
    }
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        self.pushControllerWithName("projectDetails", context: projectsModel[rowIndex])
    }
    
    func sampleData () -> [Project]{
        
        var projects = [Project]();
        for var i:Int = 0 ; i<10 ;i++
        {
            var project : Project = Project(projectId:i,projectName: "CDM "+"\(i)");
            if(i == 0 )
            {
                project.status = Project.ProjectStatus.Critical
            }
            else if (i == 1)
            {
                project.status = Project.ProjectStatus.Moderate

            }
            else
            {
                 project.status = Project.ProjectStatus.Normal
            }
            
            
            project.sprintNo = 1515
            project.totalSprint = 15
            project.apnsStatus = i % 2 == 0 ? true:false
            project.nextReleaseDate = "Feb 25, 2015"
            project.importantItem = [String]()
            project.importantItem.append("Important")
            project.importantItem.append("Important1")
            project.importantItem.append("Important2")
            project.importantItem.append("Important3")
            project.importantItem.append("Important4")
            project.featuresCompleted = [String]()
            project.featuresCompleted.append("Feature1")
            project.featuresCompleted.append("Feature2")
            project.featuresCompleted.append("Feature3")
            project.featuresCompleted.append("Feature4")
            projects.append(project);
            
        }
        let requestValues = ["Project":"get"]
        return projects
    }
    


}
