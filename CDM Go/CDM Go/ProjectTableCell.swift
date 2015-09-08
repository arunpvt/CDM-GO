//
//  ProjectTableCell.swift
//  CDM Go
//
//  Created by Developer on 28/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class ProjectTableCell : UITableViewCell
{
    @IBOutlet weak var projectName: UILabel!
    
    @IBOutlet weak var projectLogoImageView: UIImageView!
    var notificationStatus : Bool!
    @IBOutlet weak var projectStatusImageView: UIImageView!
    @IBOutlet weak var nextReleaseDateLabel: UILabel!
    
}
