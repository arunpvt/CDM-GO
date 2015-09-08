//
//  ProjectDetailsViewController.swift
//  CDM Go
//
//  Created by Developer on 31/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class ProjectDetailController : UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var projectDetailsTableView: UITableView!
//    var keyPoints :[String]!
//    var risk :[String]!
//    var featuresCompleted :[String]!
//    var featuresPending :[String]!

    var project : Project?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.title = self.project?.projectName
        self.automaticallyAdjustsScrollViewInsets = false
        self.projectDetailsTableView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.bringSubviewToFront(projectDetailsTableView)
            }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false

    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell? =  tableView.dequeueReusableHeaderFooterViewWithIdentifier("ProjectDetailsCell") as! UITableViewCell?
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ProjectDetailsCell")
           
        }
        cell!.textLabel?.textColor = UIColor(red: 215/255, green: 207/255, blue: 210/255, alpha: 1.0)

        if(indexPath.section == 0){
            getCellDetails(cell, cellIndexNumber: indexPath.row)
            
        }
        else if (indexPath.section == 1)
        {
            cell?.textLabel?.font = cell?.textLabel?.font.fontWithSize(10.0)
            cell!.textLabel?.text = self.project!.keyPoints[indexPath.row]
        }
        else if (indexPath.section == 2)
        {
            cell?.textLabel?.font = cell?.textLabel?.font.fontWithSize(10.0)
            cell!.textLabel?.text = self.project!.risks[indexPath.row]
        }
        else if (indexPath.section == 3)
        {
            cell?.textLabel?.font = cell?.textLabel?.font.fontWithSize(10.0)
            cell!.textLabel?.text = self.project!.featuresCompleted[indexPath.row]
        }
        else if (indexPath.section == 4)
        {
            cell?.textLabel?.font = cell?.textLabel?.font.fontWithSize(10.0)
            cell!.textLabel?.text = self.project!.featuresPending[indexPath.row]
        }
        cell?.backgroundColor = UIColor.clearColor()
        return cell!
        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount : Int = 0;
        
        if(section == 0)
        {
            rowCount = 3
        }
        else if(section == 1)
        {
           rowCount = self.project!.keyPoints.count
        }
        else if(section == 2)
        {
            rowCount = self.project!.risks.count
        }
        else if(section == 3)
        {
            rowCount = self.project!.featuresCompleted.count
        }
        else if(section == 4)
        {
            rowCount = self.project!.featuresPending.count
        }
        return rowCount
    }
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.alpha = 0.5
        
    }
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title : String?
        if(section == 0)
        {
            title = "Details"
        }
        else if(section == 1)
        {
            title = "Key Points"
        }
        else if (section == 2)
        {
            title = "Risks"
        }
        else if (section == 3)
        {
            title = "Features Completed"
        }
        else if (section == 4)
        {
            title = "Features Pendings"
        }
        return title
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return Int(5)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height : CGFloat = 0.0
        if(indexPath.section == 0)
        {
            height = 40.0
        }
        else
        {
            height = 25.0
        }
        return height
    }
    
    func getCellDetails (tableViewCell : UITableViewCell?,cellIndexNumber index: Int){
        
        
        tableViewCell?.textLabel?.font = tableViewCell?.textLabel?.font.fontWithSize(10.0)
        tableViewCell?.detailTextLabel?.font = tableViewCell?.detailTextLabel?.font.fontWithSize(14)
        tableViewCell!.detailTextLabel?.textColor = UIColor(red: 83/255, green: 132/255, blue: 190/255, alpha: 1.0)

        if(index == 0)
        {
            tableViewCell?.textLabel?.text = "Sprint No"
            tableViewCell!.detailTextLabel?.text = String(format: "%d / %d",self.project!.currentSprint , self.project!.totalSprint)

        }
       else if(index == 1){
            tableViewCell?.textLabel?.text = "Status"
            tableViewCell!.detailTextLabel?.text  = self.project?.projectStatus

       }
       else if(index == 2){
            tableViewCell?.textLabel?.text = "Next Release Date"
            tableViewCell!.detailTextLabel?.text = String(stringInterpolationSegment:"30-08-2015")
        }

    }
    func animateTableView()
    {
        projectDetailsTableView.reloadData()
        let cells = projectDetailsTableView.visibleCells()
        var cellIndex = 0
        for cell in cells
        {
            let uiCell : UITableViewCell = cell as! UITableViewCell
            uiCell.transform = CGAffineTransformMakeTranslation(projectDetailsTableView.bounds.size.width,0)
            UIView.animateWithDuration(0.7, delay: 0.1 * Double(cellIndex), usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                uiCell.transform = CGAffineTransformMakeTranslation(0, 0)}, completion:nil            )
            cellIndex += 1
        }
    }
    
   
   }