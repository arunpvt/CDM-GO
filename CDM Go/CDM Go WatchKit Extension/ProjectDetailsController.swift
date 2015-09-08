//
//  ProjectDetailsController.swift
//  CDM Go
//
//  Created by Developer on 02/09/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import WatchKit
import Foundation


class ProjectDetailsController: WKInterfaceController {

    @IBOutlet weak var projectDetailsTable: WKInterfaceTable!
    
    @IBOutlet weak var statusImageView: WKInterfaceImage!
    @IBOutlet weak var nextReleaseDateLabel: WKInterfaceLabel!
    @IBOutlet weak var sprintNoLabel: WKInterfaceLabel!
    
    
    private let _currentSprintNo: String = "Current Sprint No"
    private let _nextReleaseDate: String = "Next Release Date"
    private let _status: String = "Status"
    private let _importantItems: String = "KeyPoints"
    private let _featuredItems: String = "Risks"
    var project : Project!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        project = context as! Project
        self.setTitle(project.projectName)
    }
    @IBAction func OnFeatureClick() {
        self.pushControllerWithName("featureController", context: project)
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
       
        super.willActivate()
        setProjectDetails()
        loadTableRows()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    func setProjectDetails()
    {
        if(project.projectStatus == "Critical")
        {
            statusImageView.setImageNamed("Critical")
        }
        else if(project.projectStatus == "Moderate")
        {
            statusImageView.setImageNamed("Moderate")
        }
        else if(project.projectStatus == "Normal")
        {
            statusImageView.setImageNamed("Normal")
        }
        sprintNoLabel.setText(String(format: "%d / %d", project.currentSprint! , project.totalSprint! ))
        nextReleaseDateLabel.setText(project.nextReleaseDate)
    }
    func loadTableRows()
    {
        projectDetailsTable.setRowTypes(getRowTypes())
         NSLog("total Number of rows  %d ",projectDetailsTable.numberOfRows)
        for rowNumber in 0..<projectDetailsTable.numberOfRows
        {
            NSLog("rowNumber");
            let rowCell: AnyObject! = projectDetailsTable.rowControllerAtIndex(rowNumber)
            if(rowCell!.isKindOfClass(ProjectDetailListTitleRow))
            {
                var projectLabelRow : ProjectDetailListTitleRow = rowCell as! ProjectDetailListTitleRow
                var title = rowNumber == 0 ? _importantItems:_featuredItems
                projectLabelRow.itemTitle.setText(title)
                
            }
            else
            {
                var projectLabelTitleRow : ProjectDetailListItemsRow = rowCell as! ProjectDetailListItemsRow
                
                if (project.keyPoints.count > 0 && rowNumber <= project.keyPoints.count)
                {
                   projectLabelTitleRow.listItemName.setText(project.keyPoints[rowNumber-1])
                }
                else if (project.risks.count > 0 && rowNumber >= project.keyPoints.count+1)
                {
                    var riskRowNumber : Int = rowNumber
                    if (project.keyPoints.count > 0)
                    {
                        riskRowNumber = rowNumber - (project.keyPoints.count + 1)
                    }
                    projectLabelTitleRow.listItemName.setText(project.risks[riskRowNumber - 1])
                }
                else
                {
                     projectLabelTitleRow.listItemName.setText("No Items")
                }
                
            }            
        }
    }
    
    func getRowTypes() -> [String]
    {
        var rowTypes : [String] = [String]()
        println("Number of Key Items \(project.keyPoints.count)  Number of Risks Items \(project.risks.count)")
        rowTypes.append("ListTitleRow")
        if (project.keyPoints.count > 0 )
        {
            for numberOfNavigateRow in 1...project.keyPoints.count
            {
                rowTypes.append("ListItemRow")
            }
        }
        else
        {
            rowTypes.append("ListItemRow")
        }
        rowTypes.append("ListTitleRow")
        if (project.risks.count > 0 )
        {
            for numberOfNavigateRow in 1...project.risks.count
            {
                rowTypes.append("ListItemRow")
            }
            
        }
        else
        {
            rowTypes.append("ListItemRow")
        }
        return rowTypes
    }


}
