//
//  LoginViewController.swift
//  Ant Planner
//
//  Created by xiyue on 21/7/16.
//  Copyright © 2016 Ant Inc. All rights reserved.
//

import UIKit

let status = NSUserDefaults.standardUserDefaults()

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(sender: UIButton) {
        var userInfo = [String: String]()

        let usernameInput = username.text
        let passwordInput = password.text
        
        let urlStr = "https://www.antplanner.org/login.php?email=\(usernameInput!)&password=\(passwordInput!)"
        let url = NSURL(string: urlStr)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in

            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            if (responseString! == "Verified") {
                userInfo["username"] = usernameInput!
                userInfo["password"] = passwordInput!
//                userInfo["ownerId"] = "1"
                status.setObject(userInfo, forKey: "cookies")
                status.setObject(userInfo["username"], forKey: "username")
                status.setBool(true, forKey: "loggedIn")
            } else {
                
//                Prevent login.
                status.setBool(false, forKey: "loggedIn")
                
                
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        // If not logged in, present login scene; else present home
//        if status.boolForKey("loggedIn") == true {
//            self.performSegueWithIdentifier("goto_home", sender: self)
//        }
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
