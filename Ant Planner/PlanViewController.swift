//
//  MasterViewController.swift
//  Ant Planner
//
//  Created by Desperado on 7/4/28 H.
//  Copyright © 28 Heisei Ant Inc. All rights reserved.
//

import UIKit

let ownerId = ""
let password = ""

protocol PlanSelectionDelegate: class {
    func planSelected(newPlan: Plan)
}

class PlanViewController: UITableViewController {
    
    weak var delegate: PlanSelectionDelegate?
    var plans = [Plan]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plans.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        
        // Configure the cell...
        let plan = self.plans[indexPath.row]
        cell.textLabel?.text = plan.name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedPlan = self.plans[indexPath.row]
        self.delegate?.planSelected(selectedPlan)
        if let detailViewController = self.delegate as? PlanViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
    }
    
    // Add plans to view
    func addPlans(data: NSData?, response: NSURLResponse?, error: NSError?) {
        guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
            print("error")
            return
        }
        
        let dataString = String(data: data!, encoding: NSUTF8StringEncoding)
        let obj: AnyObject? = convertStringToDictionary(dataString!)
        let arr = obj!.valueForKeyPath("contents");
        for item in arr as! [Dictionary<String, AnyObject>] {
            self.plans.append(Plan(
                id: Int(item["id"] as! String)!,
                ownerId: Int(item["ownerId"] as! String)!,
                name: item["name"] as! String,
                description: item["description"] as! String,
                importance: Int(item["importance"] as! String)!,
                tag: item["customTags"] as! String,
                due: item["due"] as! String,
                rep: item["rep"] as! String,
                phoneAlarm: (item["phoneAlarm"] as! String) == "1" ? true : false,
                phonePush: (item["phonePush"] as! String) == "1" ? true : false,
                desktopPush: (item["desktopPush"] as! String) == "1" ? true : false,
                url: item["url"] as! String,
                location: item["location"] as! String,
                lat: Double(item["lat"] as! String)!,
                lng: Double(item["lng"] as! String)!))
        }
    }
    
    // Send request
    func sync() {
        sendRequest("get", url: "https://www.antplanner.org/sync.php", form: "ownerId="+ownerId+"&password="+password+"&tagFilter=All&timeFilter=All+future+plans", handler: addPlans)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        sync();
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
