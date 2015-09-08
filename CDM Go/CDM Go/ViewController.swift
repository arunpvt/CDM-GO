//
//  ViewController.swift
//  CDM Go
//
//  Created by Developer on 27/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
   
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    var effectView : UIVisualEffectView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var emailIdView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    var userInformationStorage : NSUserDefaults!
    var activityIndicator :UIActivityIndicatorView!
    @IBOutlet weak var WaitingResAcitivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var WaitingForResponsView: UIView!
    private var appDelegate : AppDelegate!
    private var isValid :Bool = false
    private var IsUserDataStorageSet : Bool!
    private var hasUser : Bool!
    private let approvalWaitingMessage = "Submitted for Admin Approval, Please contact admin"
    private let rejectedMessage = "Registration is rejected contact your administrator"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailIdTextField.delegate = self;
        userNameTextField.delegate = self;
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        activityIndicator = AppDelegate.getActivityIndicator(self.view)
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {

    }

    override func viewWillAppear(animated: Bool) {
        applyViewModifications()
        userInformationStorage = NSUserDefaults.standardUserDefaults()
        if let userName: String = userInformationStorage.objectForKey(InvokeService.USERNAMEJSONKEY) as? String
        {
            self.activityIndicator.startAnimating()
            self.view.userInteractionEnabled = false
            IsUserDataStorageSet = true
            userNameTextField.text = userName
            emailIdTextField.text = userInformationStorage.objectForKey(InvokeService.USEREMAILJSONKEY) as! String
            let (userId, userStatus , status) = InvokeService.getUser( userNameTextField.text, emailAddress: emailIdTextField.text)
            self.activityIndicator.stopAnimating()
            self.view.userInteractionEnabled = true
            showViewBasedOnUserStatus(userStatus,gotResponse: status)
        }
        else
        {
            IsUserDataStorageSet = false
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingEnds(sender: UITextField) {
        self.isValid = validateStringRegex(sender)
        if(sender.tag == 2)
        {
            self.isValid = validateEmailRegex(sender)
        }
        
    }
    
    
    @IBAction func submitAction(sender: AnyObject) {

        if(!notifyError(userNameTextField, error: nil) && !notifyError(emailIdTextField, error: nil) && !validateEmailRegex(emailIdTextField))
        {
            self.activityIndicator.startAnimating()
            self.view.userInteractionEnabled = false
            let (userId,userStatus, status) = InvokeService.getUser(self.userNameTextField.text, emailAddress: emailIdTextField.text)
            if(userId != nil)
            {
               
                if(IsUserDataStorageSet == false)
                {
                    userInformationStorage.setObject(self.userNameTextField.text, forKey: InvokeService.USERNAMEJSONKEY)
                    userInformationStorage.setObject(self.emailIdTextField.text, forKey:InvokeService.USEREMAILJSONKEY)
                    userInformationStorage.setObject(userId, forKey: InvokeService.USERIDJSONKEY)
                    
                }
            }
            showViewBasedOnUserStatus(userStatus,gotResponse: status)
            self.activityIndicator.stopAnimating()
            self.view.userInteractionEnabled = true
        }
       
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.layer.frame.origin.y = -200
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layer.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    private func showViewBasedOnUserStatus(status: String? ,gotResponse : Bool)
    {
        if(gotResponse)
        {
            if status == InvokeService.APPROVEDSTATUS
            {
                moveToNextViewController()
            
            }
            else if (status == InvokeService.REJECTEDSTATUS)
            {
                showAlertView(rejectedMessage)
            }
            else
            {
                showAlertView(approvalWaitingMessage)
            }
        }
        else
        {
             showAlertView("Some Error Occured in Network")
        }
    }
    private func moveToNextViewController()
    {
//        var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var controller :UIViewController = storyboard!.instantiateViewControllerWithIdentifier("ProjectViewController") as! UIViewController
        self.navigationController?.title = nil
        self.title = nil
        self.navigationController?.pushViewController(controller, animated: true)
    }
    private func LoadWaitingForResponseView()
    {
        WaitingForResponsView.alpha = 0.9
        WaitingForResponsView.hidden = false
        WaitingResAcitivityIndicator.startAnimating()
    }
    
    private func applyViewModifications()
    {
        
        emailIdView.alpha = 0.5
        userNameView.alpha = 0.5
        self.navigationController?.navigationBarHidden = true
        
    }
    private func notifyError(textField:UITextField, error:Bool?) ->Bool
    {
        var isError : Bool = false
        textField.layer.borderWidth = 1.0
       
        if (error == true || textField.text.isEmpty)
        {
            
            textField.layer.borderColor = UIColor.redColor().CGColor
            isError = true
        }
        else
        {
            textField.layer.borderColor = UIColor.clearColor().CGColor
                       
        }
        return isError
        
    }
    
    private func validateStringRegex(textField:UITextField) -> Bool
    {
        var valid : Bool
        let regex = NSRegularExpression(pattern: "^(?=.*[a-zA-Z])", options: nil, error: nil)
        valid = regex?.firstMatchInString(textField.text, options: nil, range: NSMakeRange(0, count(textField.text))) == nil
        notifyError(textField, error: valid)
        return valid
    }
    
    private func validateEmailRegex(textField:UITextField) -> Bool
    {
        var valid : Bool
        let regexEmail = NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: nil, error: nil)
        valid = regexEmail?.firstMatchInString(textField.text, options: nil, range: NSMakeRange(0, count(textField.text))) == nil
        notifyError(textField, error: valid)
        return valid
        
    }
    private func showAlertView(message:String)
    {
        var alertView = UIAlertView(title: "Registration", message: message, delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    private func clearNSDefaultDictionary()
    {
        let bundleId = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(bundleId!)
    }
    
}

