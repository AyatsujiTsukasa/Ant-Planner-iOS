//
//  DetailViewController.swift
//  Ant Planner
//
//  Created by Desperado on 7/4/28 H.
//  Copyright © 28 Heisei Ant Inc. All rights reserved.
//

import UIKit

class AddPlanController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //点击button后提交/删除plan的事件还没有添加
    //还有change rep from string to int when add a plan
    @IBOutlet weak var planName: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var importance = 1
    @IBOutlet weak var planDesc: UITextField!
    @IBOutlet weak var tag: UITextField!
    @IBOutlet weak var due: UITextField!
    @IBAction func dueEditing(sender: UITextField) {
        let datePickerView = UIDatePicker()
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(AddPlanController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    @IBOutlet weak var rep: UITextField!
    @IBOutlet weak var phoneAlarm: UISwitch!
    @IBOutlet weak var phonePush: UISwitch!
    @IBOutlet weak var desktopPush: UISwitch!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var location: UITextField!
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            importance = 1
        case 1:
            importance = 2
        case 2:
            importance = 3
        default:
            importance = 1
        }
    }
    
    var plan: Plan! {
        didSet (newPlan) {
            self.refreshUI()
        }
    }
    
    var tagOptions = ["Work", "Study", "Family", "Personal"]
    var repeatOptions = ["Never", "Every Day", "Every Week", "Every Month", "Every Year"]
    
    func refreshUI() {
        planName?.text = plan.name
        planDesc?.text = plan.description
        segmentedControl.setEnabled(true, forSegmentAtIndex: plan.importance)
        tag?.text = plan.tag
        due?.text = plan.due
//        if plan.rep != NSNull 
//        print(plan.rep)
//            switch plan.rep {
//                case "1":
//                    rep?.text = "Every Day"
//                    break
//                case "2":
//                    rep?.text = "Every Week"
//                    break
//                case "3":
//                    rep?.text = "Every Month"
//                    break
//                case "4":
//                    rep?.text = "Every Year"
//                    break
//                default:
//                    rep?.text = "Never"
//                    break
//                }
//            }
        phoneAlarm?.on = plan.phoneAlarm
        phonePush?.on = plan.phonePush
        desktopPush?.on = plan.desktopPush
        url?.text = plan.url
        location?.text = plan.location
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tagPickerView = UIPickerView()
        tagPickerView.tag = 0
        let repeatPickerView = UIPickerView()
        repeatPickerView.tag = 2
        tagPickerView.delegate = self
        repeatPickerView.delegate = self
        tag.inputView = tagPickerView
        rep.inputView = repeatPickerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return tagOptions.count
        }
        if pickerView.tag == 2 {
            return repeatOptions.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return tagOptions[row]
        }
        if pickerView.tag == 2 {
            return repeatOptions[row]
        }
        return " "
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            tag.text = tagOptions[row]
        }
        if pickerView.tag == 2 {
            rep.text = repeatOptions[row]
        }
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        due.text = dateFormatter.stringFromDate(sender.date)
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

extension AddPlanController: PlanSelectionDelegate {
    func planSelected(newPlan: Plan) {
        plan = newPlan
    }
}
