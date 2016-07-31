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

        // let usernameInput = uername.text
        // let passwordInput = password.text
        
        // Check if usernameInput and passwordInput match
        // Retrieve id from database
        
        // Example of alert message when log in fails
        /* if ... {
            var alertView = UIAlertView()
            alertView.title = "Log In Failed!"
            alertView.message = "Please enter username and password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
         } else if ... {
            .....
         } */
        
        /* If inputs are valid
        userInfo["username"] = usernameInput!
        userInfo["password"] = passwordInput!
        userInfo["ownerId"] = id
        */
        
        //因为现在还没有实现连接数据库，所以这里就直接用eeeeasy的帐号测试了……
        userInfo["username"] = "eeeeasy"
        userInfo["password"] = "ant123"
        userInfo["ownerId"] = "3"
        
        status.setObject(userInfo, forKey: "cookies")
        status.setObject(userInfo["username"], forKey: "username")
        status.setBool(true, forKey: "loggedIn")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        // If not logged in, present login scene; else present home
        if status.boolForKey("loggedIn") == true {
            self.performSegueWithIdentifier("goto_home", sender: self)
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
