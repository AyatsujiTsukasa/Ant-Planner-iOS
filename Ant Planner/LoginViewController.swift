//
//  LoginViewController.swift
//  Ant Planner
//
//  Created by xiyue on 21/7/16.
//  Copyright © 2016 Ant Inc. All rights reserved.
//

import UIKit

let status = NSUserDefaults.standardUserDefaults()

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(sender: UIButton) {
        submit()
    }
    
    private func submit() {
        let emailInput = email.text
        let passwordInput = password.text
        
        let urlStr = "https://www.antplanner.org/login.php?email=\(emailInput!)&password=\(passwordInput!)"
        let url = NSURL(string: urlStr)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if (responseString! == "Verified") {
                status.setBool(true, forKey: "loggedIn")
                dispatch_async(dispatch_get_main_queue(), {
                    self.performSegueWithIdentifier("goto_home", sender: self)
                })
            } else {
                let info = Utility.matchesForRegexInText("<li\\b[^>]*>(.*?)</li>", text: responseString as! String).map(Utility.extract)
                var message = ""
                for i in info {
                    message = message + "\n" + i
                }
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0), {
                    let alertController = UIAlertController(title: "Failed", message: message, preferredStyle: .Alert)
                    let retryAction = UIAlertAction(title: "Retry", style: .Default, handler:nil)
                    alertController.addAction(retryAction)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                })
                status.setBool(false, forKey: "loggedIn")
            }
        }
        task.resume()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.returnKeyType == .Go {
            submit()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        // If not logged in, present login scene; else present home
        if status.boolForKey("loggedIn") == true && status.boolForKey("notFirstTime") == true{
            self.performSegueWithIdentifier("goto_home", sender: self)
        } else {
            status.setBool(true, forKey: "notFirstTime")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
