//
//  MasterViewController.swift
//  Ant Planner
//
//  Created by Desperado on 7/4/28 H.
//  Copyright © 28 Heisei Ant Inc. All rights reserved.
//

import UIKit

class PlanViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    let url = "https://www.antplanner.org/userhome.html"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserCookie.addUserCookie()
        
        let requestURL = NSURL(string: url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
