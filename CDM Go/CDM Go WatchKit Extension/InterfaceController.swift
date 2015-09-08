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

    @IBOutlet weak var groupRegister: WKInterfaceGroup!
    @IBOutlet weak var projectTable: WKInterfaceTable!
    var projectsModel : [Project]!
    let projects = ["CDM","Driver Seat","Tymetrix"]
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
       
        println("End")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        WKInterfaceController.openParentApplication(["Project":"get"]) { (userInfo:[NSObject : AnyObject]!, error: NSError!) -> Void in
            if ((error) != nil) {
                println(error)
                return
            }
            else
            {
                 if let projectDetails: String = userInfo["project"] as? String
                 {
                    if (projectDetails  == "Failure")
                    {
                       self.groupRegister!.setHidden(false)
                    }
                 }
                else
                 {
                    self.groupRegister!.setHidden(true)
                    self.projectsModel = Project.deserializeJsonObject(userInfo["project"]!)
                    self.loadTableRows()
                }
                
            }
        }
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
            
            row.projectName.setText(project.projectName)
            println(project.projectStatus)
            if(project.projectStatus == "Critical")
            {
                row.projectAlertImageView.setImageNamed("Critical")
            }
            else if(project.projectStatus == "Moderate")
            {
                row.projectAlertImageView.setImageNamed("Moderate")
            }
            else if(project.projectStatus == "Normal")
            {
                
                row.projectAlertImageView.setImageNamed("Normal")
            }
            ++i
        }
    }
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        self.pushControllerWithName("projectDetails", context: projectsModel[rowIndex])
    }
  


}
