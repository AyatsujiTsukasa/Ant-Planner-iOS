//
//  DetailViewController.swift
//  Ant Planner
//
//  Created by Desperado on 7/4/28 H.
//  Copyright © 28 Heisei Ant Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var planName: UITextField!
    @IBOutlet weak var planDesc: UITextField!
    @IBOutlet weak var tag: UITextField!
    @IBOutlet weak var due: UITextField!
    @IBOutlet weak var rep: UITextField!
    @IBOutlet weak var phoneAlarm: UISwitch!
    @IBOutlet weak var phonePush: UISwitch!
    @IBOutlet weak var desktopPush: UISwitch!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var location: UITextField!
    
    var plan: Plan! {
        didSet (newPlan) {
            self.refreshUI()
        }
    }
    
    func refreshUI() {
        planName?.text = plan.name
        planDesc?.text = plan.description
        tag?.text = plan.tag
        due?.text = plan.due
//        if plan.rep != NSNull 
        print(plan.rep)
            switch plan.rep {
            case "1":
                rep?.text = "Every Day"
                break
            case "2":
                rep?.text = "Every Week"
                break
            case "3":
                rep?.text = "Every Month"
                break
            case "4":
                rep?.text = "Every Year"
                break
            default:
                rep?.text = "Never"
                break
            }
//        }
        phoneAlarm?.on = plan.phoneAlarm
        phonePush?.on = plan.phonePush
        desktopPush?.on = plan.desktopPush
        url?.text = plan.url
        location?.text = plan.location
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

extension DetailViewController: PlanSelectionDelegate {
    func planSelected(newPlan: Plan) {
        plan = newPlan
    }
}
