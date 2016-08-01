//
//  RegisterViewController.swift
//  Ant Planner
//
//  Created by xiyue on 20/7/16.
//  Copyright © 2016 Ant Inc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    
    @IBAction func register(sender: UIButton) {
        submit()
    }
    
    private func submit() {
        let usernameInput = username.text
        let emailInput = email.text
        let passwordInput = password.text
        let confirmPasswordInput = confirm.text
        
        let urlStr = "https://www.antplanner.org/register.php?username=\(usernameInput!)&email=\(emailInput!)&password=\(passwordInput!)&password2=\(confirmPasswordInput!)"
        let url = NSURL(string: urlStr)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            let info = Utility.matchesForRegexInText("<li\\b[^>]*>(.*?)</li>", text: responseString as! String).map(Utility.extract)
            var message = ""
            for i in info {
                message = message + "\n" + i
            }
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            if (Utility.matchesForRegexInText("Account Created", text: responseString as! String).count > 0) {
                // Account Created.
                dispatch_async(dispatch_get_global_queue(priority, 0), {
                    let alertController = UIAlertController(title: "Account Created!", message: message, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: {
                        action in self.performSegueWithIdentifier("account_created", sender: self)
                    })
                    alertController.addAction(okAction)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                })
            } else {
                // Error
                dispatch_async(dispatch_get_global_queue(priority, 0), {
                    let alertController = UIAlertController(title: "Failed", message: message, preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Retry", style: .Default, handler:nil)
                    alertController.addAction(okAction)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                })
            }
        }
        task.resume()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField.returnKeyType == .Join) {
            submit()
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.delegate = self
        email.delegate = self
        password.delegate = self
        confirm.delegate = self

        // Do any additional setup after loading the view.
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
