//
//  RegisterViewController.swift
//  Ant Planner
//
//  Created by xiyue on 20/7/16.
//  Copyright © 2016 Ant Inc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!

    func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matchesInString(text,
                                                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substringWithRange($0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    func extract(str: String) -> String {
        return str.substringWithRange(Range<String.Index>(str.startIndex.advancedBy(4)..<str.endIndex.advancedBy(-5)))
    }
    
    @IBAction func register(sender: UIButton) {
        
        let usernameInput = username.text
        let emailInput = email.text
        let passwordInput = password.text
        let confirmPasswordInput = confirm.text
        
        let urlStr = "https://www.antplanner.org/register.php?username=\(usernameInput!)&email=\(emailInput!)&password=\(passwordInput!)&password2=\(confirmPasswordInput!)"
        let url = NSURL(string: urlStr)
        print(urlStr)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            let info = self.matchesForRegexInText("<li\\b[^>]*>(.*?)</li>", text: responseString as! String).map(self.extract)
            print(info)
            
            if (self.matchesForRegexInText("Account Created", text: responseString as! String).count > 0) {
//                Account Created.
//                Alert ("success", info).
            } else {
//                Error.
//                Alert ("Failed", info).
            }
            
            //
            
        }
        task.resume()
        
        // Example of alert message when sign up fails
        /* if (...) {
            var alertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter a valid email address"
            alertView.delegate = self
            alertVoew.addButtonWithTitle("OK")
            alertView.show()
        } else if (....) {
            .....
        } */
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
