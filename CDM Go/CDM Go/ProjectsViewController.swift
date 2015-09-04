//
//  ProjectsViewController.swift
//  CDM Go
//
//  Created by Developer on 28/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{
        var projects : [Project] = [Project]()
    
    @IBOutlet weak var projectTableView: UITableView!
    override func viewDidLoad() {
        sleep(2)
        projects = ProjectsViewController.sampleData()
        super.viewDidLoad()
        self.title = "Projects"
        self.automaticallyAdjustsScrollViewInsets = false
        self.projectTableView.tableFooterView = UIView()
        self.projectTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
//        var imageView :UIImageView = UIImageView(image: UIImage(named: "new_york_city_colors-wide.png"))
//        imageView.frame = self.projectTableView.frame
//        imageView.alpha = 0.6
//        self.projectTableView.backgroundColor = UIColor.clearColor()
//        self.projectTableView.backgroundView = imageView
        
        
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        var cell  = tableView.dequeueReusableCellWithIdentifier("ProjectTableCell") as! ProjectTableCell
        cell.backgroundColor = projectTableView.backgroundColor
        cell.projectName.text = projects[indexPath.row].name
        cell.notificationStatus = false
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return projects.count
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let products = ["iPhone", "Apple Watch", "Mac", "iPad"]
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! ProjectTableCell
        var enable = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Enable") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            cell.notificationStatus = true
            print("\(tableView.editing)")
            tableView.editing = false
        }
        
        var disable = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Disable"){ (action: UITableViewRowAction!, indexPath : NSIndexPath!) -> Void in
            cell.notificationStatus = false
            tableView.editing = false
        }
        if(cell.notificationStatus == true)
        {
            enable.backgroundColor = setBackGroundColor(cell.notificationStatus)
            disable.backgroundColor = setBackGroundColor(!cell.notificationStatus)
        }
        else
        {
            disable.backgroundColor = setBackGroundColor(!cell.notificationStatus)
            enable.backgroundColor = setBackGroundColor(cell.notificationStatus)
        }
        
        return [disable,enable]
        
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
       
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! ProjectTableCell
        var controller  = storyBoard.instantiateViewControllerWithIdentifier("ProjectDetailController") as! ProjectDetailController
          controller.project = projects[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    static func sampleData () -> [Project]{
        
        var projects = [Project]();
        //var i :Int
        for var i:Int = 0 ; i<40 ;i++
        {
            var project : Project = Project(projectId:i,projectName: "CDM "+"\(i)");
            project.status = Project.ProjectStatus.Normal
            project.sprintNo = 10
            project.totalSprint = 15
            project.apnsStatus = i % 2 == 0 ? true:false
          
            projects.append(project);
        }
        return projects
    }
    
    func setBackGroundColor(status : Bool)->UIColor
    {
        var color:UIColor!
        if(status)
        {
            color = UIColor(red: 252/255, green: 71/255, blue: 71/255, alpha: 1)
            
        }
        else
        {
            color = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        }
        return color
    }
    
}

