//
//  ProjectDetailsViewController.swift
//  CDM Go
//
//  Created by Developer on 31/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class ProjectDetailController : UIViewController,UITableViewDataSource,UITableViewDelegate ,UIGestureRecognizerDelegate{
    let none = "None"
    
    @IBOutlet weak var projectDetailsTableView: UITableView!
//    var keyPoints :[String]!
//    var risk :[String]!
//    var featuresCompleted :[String]!
//    var featuresPending :[String]!

    var projects : [Project]!
    var project : Project!
    var indexValue : Int!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        addGestures()
        
           }
   
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        loadProjectFromIndex(indexValue)
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
            cell!.textLabel?.text = self.project!.keyPoints.count == 0 ? none :self.project!.keyPoints[indexPath.row]
        }
        else if (indexPath.section == 2)
        {
            cell!.textLabel?.text = self.project!.risks.count == 0 ? none : self.project!.risks[indexPath.row]
        }
        else if (indexPath.section == 3)
        {
            cell!.textLabel?.text =  self.project!.featuresCompleted.count == 0 ? none:self.project!.featuresCompleted[indexPath.row]
        }
        else if (indexPath.section == 4)
        {
            cell!.textLabel?.text = self.project!.featuresPending.count == 0 ? none:self.project!.featuresPending[indexPath.row]
        }
        if (indexPath.section > 0)
        {
            cell!.textLabel?.textColor = UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1.0)
            cell!.textLabel?.font = cell?.textLabel?.font.fontWithSize(25)
        
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
            rowCount = self.project!.keyPoints.count == 0 ? 1 : self.project!.keyPoints.count
        }
        else if(section == 2)
        {
            rowCount = self.project!.risks.count  == 0 ? 1 : self.project!.risks.count
        }
        else if(section == 3)
        {
            rowCount = self.project!.featuresCompleted.count  == 0 ? 1 : self.project!.featuresCompleted.count
        }
        else if(section == 4)
        {
            rowCount = self.project!.featuresPending.count == 0 ? 1 :  self.project!.featuresPending.count
        }
        return rowCount
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView : UIView!
        if(section > 0 )
        {
        headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 60))
        var label = UILabel(frame: CGRectMake(15, 10, tableView.frame.width, 50))
        label.font = label.font.fontWithSize(30)
        label.textColor = UIColor(red: 68/255, green: 171/255, blue: 171/255, alpha: 1.0)
        label.text = "test"
        headerView.addSubview(label)
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        headerView.alpha = 0.8
        
        if(section == 1)
        {
            label.text = "Key Points"
        }
        else if (section == 2)
        {
            label.text = "Risks"
        }
        else if (section == 3)
        {
            
            label.text = "Features Completed"
        }
        else if (section == 4)
        {
           label.text = "Features Pendings"
        }
        return headerView
        }
        else
        {
            headerView = UIView()
        }
        return headerView
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return Int(5)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section > 0)
        {
        return CGFloat(60)
            
        }
        return CGFloat (0)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height : CGFloat = 80.0
       
        return height
    }
    
    func getCellDetails (tableViewCell : UITableViewCell?,cellIndexNumber index: Int){
        
        
        tableViewCell?.textLabel?.font = tableViewCell?.textLabel?.font.fontWithSize(20)
        tableViewCell?.detailTextLabel?.font = tableViewCell?.detailTextLabel?.font.fontWithSize(30)
        tableViewCell!.detailTextLabel?.textColor = UIColor(red: 95/255, green: 142/255, blue: 188/255, alpha: 1.0)
        tableViewCell!.textLabel?.textColor = UIColor(red: 141/255, green: 141/255, blue: 141/255, alpha: 1.0)

        if(index == 0)
        {
            tableViewCell?.textLabel?.text = "Sprint#"
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
    private func addGestures()
    {
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: "moveBackWard")
    rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
    self.projectDetailsTableView.addGestureRecognizer(rightSwipe)
    rightSwipe.delegate = self

    let backWardSwipe = UISwipeGestureRecognizer(target: self, action: "moveForward")
    backWardSwipe.direction = UISwipeGestureRecognizerDirection.Left
    self.projectDetailsTableView.addGestureRecognizer(backWardSwipe)
    backWardSwipe.delegate = self

    }
    func moveForward()
    {
     self.indexValue = self.indexValue + 1
     if(indexValue >= 0 && indexValue < self.projects.count)
     {
        loadProjectFromIndex(indexValue)
        projectDetailsTableView.reloadData()
     }
     else
     {
         self.indexValue = self.projects.count - 1
     }
    }
    func moveBackWard()
    {
        self.indexValue = self.indexValue - 1
        if(indexValue >= 0)
        {
            loadProjectFromIndex(indexValue)
            projectDetailsTableView.reloadData()
            
        }
        else
        {
            self.indexValue = 0
        }
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func loadProjectFromIndex(index:Int!)
    {
        self.project = self.projects[index]
        self.title = self.project.projectName
    }
   
   }