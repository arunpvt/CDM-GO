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
    var importItems :[String] = ["Items 1","Items 2","Items 3","Items 4","Items 5"]
    var majorItems :[String] = ["MItems 1","MItems 2","MItems 3","MItems 4","MItems 5"]
    var project : Project?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.title = self.project?.name
        self.automaticallyAdjustsScrollViewInsets = false
        self.projectDetailsTableView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        self.view.bringSubviewToFront(projectDetailsTableView)
    }
    override func viewWillAppear(animated: Bool) {
        //animateTableView()
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell? =  tableView.dequeueReusableHeaderFooterViewWithIdentifier("ProjectDetailsCell") as! UITableViewCell?
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "ProjectDetailsCell")
           
        }
        if(indexPath.section == 0){
            getCellDetails(cell, cellIndexNumber: indexPath.row)
            
        }
        else if (indexPath.section == 1)
        {
            cell?.textLabel?.font = cell?.textLabel?.font.fontWithSize(10.0)
            cell!.textLabel?.text = majorItems[indexPath.row]
        }
        else if (indexPath.section == 2)
        {
            cell?.textLabel?.font = cell?.textLabel?.font.fontWithSize(10.0)
            cell!.textLabel?.text = importItems[indexPath.row]
        }
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
           rowCount = importItems.count
        }
        else if(section == 2)
        {
            rowCount = majorItems.count
        }
        return rowCount
    }
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title : String?
        if(section == 0)
        {
            title = "Details"
        }
        else if(section == 1)
        {
            title = "Important Items"
        }
        else
        {
            title = "Major Items"
        }
        return title
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return Int(3)
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
        
        tableViewCell?.textLabel?.textColor = UIColor(red: 79/255, green: 187/255, blue: 255/255, alpha: 1.0)
        tableViewCell?.textLabel?.font = tableViewCell?.textLabel?.font.fontWithSize(10.0)
        tableViewCell?.detailTextLabel?.font = tableViewCell?.detailTextLabel?.font.fontWithSize(14)
        if(index == 0)
        {
            tableViewCell?.textLabel?.text = "Sprint No"
            tableViewCell!.detailTextLabel?.text = String(format: "%d / %d",self.project!.sprintNo , self.project!.totalSprint)

        }
       else if(index == 1){
            tableViewCell?.textLabel?.text = "Status"
            tableViewCell!.detailTextLabel?.text  = self.project?.status?.rawValue

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