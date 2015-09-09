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
    var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var projectTableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Projects"
        self.automaticallyAdjustsScrollViewInsets = false
        self.projectTableView.tableFooterView = UIView()
        self.projectTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        activityIndicator = AppDelegate.getActivityIndicator(self.view)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadProjects", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
        self.activityIndicator.startAnimating()
        self.view.userInteractionEnabled = false
        
        NSThread.detachNewThreadSelector(Selector("loadProjects"), toTarget: self, withObject: nil)
    }
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        var cell  = tableView.dequeueReusableCellWithIdentifier("ProjectTableCell") as! ProjectTableCell
        cell.backgroundColor = UIColor.clearColor()
        cell.projectName.text = projects[indexPath.row].projectName
        cell.notificationStatus = false
        var statusImage:UIImage!
        println(projects[indexPath.row].projectStatus)
        if(projects[indexPath.row].projectStatus == "Critical")
        {
            statusImage = UIImage(named: "Critical")
        }
        else if(projects[indexPath.row].projectStatus == "Normal")
        {
            statusImage = UIImage(named: "Normal")
        }
        else if(projects[indexPath.row].projectStatus == "Moderate")
        {
            statusImage = UIImage(named: "Moderate")
        }
        var logoImages = ["pro1","Pro2","Pro3","Pro5"]
        cell.projectLogoImageView.image = UIImage(named: logoImages[indexPath.row % 4])
        cell.alpha = 0.3
        cell.projectStatusImageView.image = statusImage
        cell.nextReleaseDateLabel.text = projects[indexPath.row].nextReleaseDate
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return projects.count
    }
    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//        var cell = tableView.cellForRowAtIndexPath(indexPath) as! ProjectTableCell
//        var enable = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Enable") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
//            cell.notificationStatus = true
//            print("\(tableView.editing)")
//            tableView.editing = false
//        }
//        
//        var disable = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Disable"){ (action: UITableViewRowAction!, indexPath : NSIndexPath!) -> Void in
//            cell.notificationStatus = false
//            tableView.editing = false
//        }
//        if(cell.notificationStatus == true)
//        {
//            enable.backgroundColor = setBackGroundColor(cell.notificationStatus)
//            disable.backgroundColor = setBackGroundColor(!cell.notificationStatus)
//        }
//        else
//        {
//            disable.backgroundColor = setBackGroundColor(!cell.notificationStatus)
//            enable.backgroundColor = setBackGroundColor(cell.notificationStatus)
//        }
//        
//        return [disable,enable]
//        
//    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
//    {
//       
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! ProjectTableCell
        var controller  = storyBoard.instantiateViewControllerWithIdentifier("ProjectDetailController") as! ProjectDetailController
          controller.projects = projects
          controller.indexValue = indexPath.row
        self.navigationController?.pushViewController(controller, animated: true)
        
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
    func showErrorAlertMessage()
    {
        var alert = UIAlertView(title: "Projects", message: "Some Error had incurred", delegate: self, cancelButtonTitle: "OK")
    }

    func loadProjects()
    {
        var appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let responseData :AnyObject! = appDelegate.syncData()
        self.projects = InvokeService.deserializeJsonObject(responseData)
        dispatch_async(dispatch_get_main_queue(), {
            
            self.activityIndicator.stopAnimating()
            self.view.userInteractionEnabled = true
            self.projectTableView.reloadData()
        })
    }
}

