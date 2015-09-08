//
//  FeaturesController.swift
//  CDM Go
//
//  Created by Developer on 08/09/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit
import WatchKit

class FeaturesController: WKInterfaceController {
   private let _featureCompleted = "Completed"
   private let _featurePendings = "Pendings"
    @IBOutlet weak var featuresTable: WKInterfaceTable!
    
    var featuresCompleted :[String] = [String]()
    var featuresPending :[String] = [String]()
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Features")
        let project = context as! Project
        self.featuresCompleted = project.featuresCompleted
        self.featuresPending = project.featuresPending
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        super.willActivate()
        loadTableRows()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func loadTableRows()
    {
        featuresTable.setRowTypes(getRowTypes())
        NSLog("total Number of rows  %d ",featuresTable.numberOfRows)
        for rowNumber in 0..<featuresTable.numberOfRows
        {
            NSLog("rowNumber");
            let rowCell: AnyObject! = featuresTable.rowControllerAtIndex(rowNumber)
            if(rowCell!.isKindOfClass(ProjectDetailListTitleRow))
            {
                var projectLabelRow : ProjectDetailListTitleRow = rowCell as! ProjectDetailListTitleRow
                var title = rowNumber == 0 ? _featureCompleted:_featurePendings
                projectLabelRow.itemTitle.setText(title)
                
            }
            else
            {
                var projectLabelTitleRow : ProjectDetailListItemsRow = rowCell as! ProjectDetailListItemsRow
                
                if (featuresCompleted.count > 0 && rowNumber <= featuresCompleted.count)
                {
                    projectLabelTitleRow.listItemName.setText(featuresCompleted[rowNumber-1])
                }
                else if (featuresPending.count > 0 && rowNumber >= featuresPending.count+1)
                {
                    var riskRowNumber : Int = rowNumber
                    if (featuresCompleted.count > 0)
                    {
                        riskRowNumber = rowNumber - (featuresCompleted.count + 1)
                    }
                    projectLabelTitleRow.listItemName.setText(featuresPending[riskRowNumber - 1])
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
        println("Number of Key Items \(featuresCompleted.count)  Number of Risks Items \(featuresPending.count)")
        rowTypes.append("ListTitleRow")
        if (featuresCompleted.count > 0 )
        {
            for numberOfNavigateRow in 1...featuresCompleted.count
            {
                rowTypes.append("ListItemRow")
            }
        }
        else
        {
            rowTypes.append("ListItemRow")
        }
        rowTypes.append("ListTitleRow")
        if (featuresPending.count > 0 )
        {
            for numberOfNavigateRow in 1...featuresPending.count
            {
                rowTypes.append("ListItemRow")
            }
            
        }
        else
        {
            rowTypes.append("ListItemRow")
        }
        //rowTypes.append("FeaturesRowController")
        return rowTypes
    }
}
