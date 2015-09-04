//
//  ViewController.swift
//  CDM Go
//
//  Created by Developer on 27/08/15.
//  Copyright (c) 2015 OFS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    var isValid :Bool = false
    var effectView : UIVisualEffectView?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.0)
        loginView.layer.borderColor =  UIColor.whiteColor().CGColor
        loginView.layer.borderWidth = 0.4;
        loginView.layer.cornerRadius = 10
        self.animate()
        
        //registerButton.enabled = false
    
        // Do any additional setup after loading the view, typically from a nib.
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
            loginView.alpha = 0.2
            effectView?.alpha = 1.0
            activityIndicator.startAnimating()
            
            
            var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var controller :UIViewController = storyboard!.instantiateViewControllerWithIdentifier("ProjectViewController") as! UIViewController
            var navController = UINavigationController(rootViewController: controller)
             self.presentViewController(navController, animated: true, completion: nil)

        }
       // self.performSegueWithIdentifier("seg", sender: self)
    }
    
    func animate()
    {
        UIView.beginAnimations("test", context: nil)
        UIView.setAnimationDuration(1.2)
        UIView.setAnimationDelay(0.2)
        //UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut);
        //effectView!.alpha = 0.1
        UIView.commitAnimations()
        
    }
    func notifyError(textField:UITextField, error:Bool?) ->Bool
    {
        var isError : Bool = false
        var errorImageName : String = "delete.png"
        var validImageName : String = "ok.png"
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 4
       
        if (error == true || textField.text.isEmpty)
        {
            
            textField.layer.borderColor = UIColor.redColor().CGColor
            isError = true
        }
        else
        {
            textField.layer.borderColor = UIColor.greenColor().CGColor
                       
        }
        return isError
        
    }
    func validateStringRegex(textField:UITextField) -> Bool
    {
        var valid : Bool
        let regex = NSRegularExpression(pattern: "^(?=.*[a-zA-Z])", options: nil, error: nil)
        valid = regex?.firstMatchInString(textField.text, options: nil, range: NSMakeRange(0, count(textField.text))) == nil
        notifyError(textField, error: valid)
        return valid
    }
    func validateEmailRegex(textField:UITextField) -> Bool
    {
        var valid : Bool
        let regexEmail = NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: nil, error: nil)
        valid = regexEmail?.firstMatchInString(textField.text, options: nil, range: NSMakeRange(0, count(textField.text))) == nil
        notifyError(textField, error: valid)
        return valid
        
    }

}

