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
    @IBOutlet weak var projectTitleLabel: WKInterfaceLabel!
    @IBOutlet weak var nextReleaseDateLabel: WKInterfaceLabel!
    @IBOutlet weak var sprintNoLabel: WKInterfaceLabel!
    
    private let _currentSprintNo: String = "Current Sprint No"
    private let _nextReleaseDate: String = "Next Release Date"
    private let _status: String = "Status"
    private let _importantItems: String = "Important Items"
    private let _featuredItems: String = "Featured Items"
    var project : Project!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        project = context as! Project
        self.setTitle(project.name)
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
        if(project.status == Project.ProjectStatus.Critical)
        {
            statusImageView.setImageNamed("High Priority-50.png")
        }
        else if(project.status == Project.ProjectStatus.Moderate)
        {
            statusImageView.setImageNamed("Medium Priority-50")
        }
        else if(project.status == Project.ProjectStatus.Normal)
        {
            statusImageView.setImageNamed("Low Priority-50")
        }
        projectTitleLabel.setText(project.name)
        sprintNoLabel.setText(String(format: "%d / %d", project.sprintNo! , project.totalSprint! ))
        nextReleaseDateLabel.setText(project.nextReleaseDate)
    }
    func loadTableRows()
    {
        projectDetailsTable.setRowTypes(getRowTypes())
         NSLog("total Number of rows  %d ",projectDetailsTable.numberOfRows)
        for rowNumber in 0..<projectDetailsTable.numberOfRows
        {
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
                if (project.importantItem.count > 0 && rowNumber <= project.importantItem.count)
                {
                   projectLabelTitleRow.listItemName.setText(project.importantItem[rowNumber-1])
                }
                else
                {
                    var featureRowNumber : Int = rowNumber
                    if (project.importantItem.count > 0)
                    {
                        featureRowNumber = rowNumber - (project.importantItem.count + 1)
                    }
                    projectLabelTitleRow.listItemName.setText(project.featuresCompleted[featureRowNumber - 1])
                }
            }            
        }
    }
//    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
//        if(rowIndex > 2)
//        {
//            let rowCell: AnyObject! = projectDetailsTable.rowControllerAtIndex(rowIndex)
//            var itemsCollection : [String]!
//            var title :String!
//            if(rowCell.isKindOfClass(ProjectLabelNavigationRow))
//            {
//                let projectNavRow = rowCell as! ProjectLabelNavigationRow
//                 NSLog("Items Count %d ",project.importantItem.count) //), //project.featuresCompleted.count)
//                if(table.numberOfRows > 4)
//                {
//                    itemsCollection = rowIndex == 3 ? project.importantItem : project.featuresCompleted
//                     NSLog("Items Count %d", project.importantItem.count)
//                }
//                else
//                {
//                    itemsCollection = project.importantItem.count > 0 ? project.importantItem : project.featuresCompleted
//                    NSLog(" Items Count %d", project.featuresCompleted.count)
//                }
//            }
//           NSLog(" Assingned Items Count %d", itemsCollection.count)
//            self.pushControllerWithName("itemDetailsController", context:itemsCollection)
//        }
//        
//    }
    
    func getRowTypes() -> [String]
    {
        var rowTypes : [String] = [String]()
        println("Number of Important Items \(project.importantItem.count)  Number of Important Items \(project.featuresCompleted.count)")
        if (project.importantItem.count > 0 ) //&& project.featuresCompleted.count > 0 )
        {
            rowTypes.append("ListTitleRow")
            
            for numberOfNavigateRow in 1...project.importantItem.count
            {
                rowTypes.append("ListItemRow")
            }
        }
        if (project.featuresCompleted.count > 0 )
        {
            rowTypes.append("ListTitleRow")
            
            for numberOfNavigateRow in 1...project.featuresCompleted.count
            {
                rowTypes.append("ListItemRow")
            }
            
        }
        return rowTypes
    }
    
//    func setRowInformation(rowNumber : Int, row :ProjectLabelRow, projectDetails:Project)
//    {
//        if(rowNumber == 0)
//        {
//            row.titleLabel.setText(_currentSprintNo)
//            var descriptionText : String = NSNumber(integer: projectDetails.sprintNo!).stringValue
//            row.descriptionLabel.setText(descriptionText)
//        }
//        else if (rowNumber == 1)
//        {
//            row.titleLabel.setText(_status)
//            row.descriptionLabel.setText(projectDetails.status?.rawValue)
//
//        }
//        else
//        {
//            row.titleLabel.setText(_nextReleaseDate)
//            row.descriptionLabel.setText(projectDetails.nextReleaseDate)
//
//        }
//    }

}
