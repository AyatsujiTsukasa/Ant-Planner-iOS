//
//  TimerViewController.swift
//  Ant Planner
//
//  Created by xiyue on 20/7/16.
//  Copyright © 2016 Ant Inc. All rights reserved.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    var startTime = NSTimeInterval();
    var endTime = NSTimeInterval();
    var timer = NSTimer()
    
    let workTime: NSTimeInterval = 25 * 60
    let breakTime: NSTimeInterval = 5 * 60
    let longBreak: NSTimeInterval = 25 * 60
    var work = false
    var count = 0

    let blue = UIColor.init(red: 66/255, green: 139/255, blue: 202/255, alpha: 1)
    let green = UIColor.init(red: 92/255, green: 184/255, blue: 92/255, alpha: 1)
    
    @IBOutlet weak var displayTimeLabel: UILabel!
    @IBOutlet weak var ctrlButton: UIButton!
    @IBOutlet weak var task: UITextField!
    @IBOutlet weak var taskName: UILabel!
    @IBAction func control(sender: UIButton) {
        if !timer.valid {
            taskName.text = task.text
            taskName.hidden = false
            task.hidden = true
            ctrlButton.setTitle("Stop", forState: .Normal)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            endTime = startTime + workTime + 1
            work = true
            count = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            taskName.hidden = true
            taskName.text = ""
            task.hidden = false
            displayTimeLabel.text = "25:00"
            displayTimeLabel.textColor = green
            ctrlButton.setTitleColor(green, forState: .Normal)
            ctrlButton.setTitle("Start", forState: .Normal)
        }
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var diff: NSTimeInterval = endTime - currentTime
        if diff < 0 {
            if work {
                work = false
                count += 1
                if count % 4 == 0 {
                    diff = longBreak
                    showNotification("Break", notifiBody: "Take a 25-minute break")
                } else {
                    diff = breakTime
                    showNotification("Break", notifiBody: "Take a 5-minute break")
                }
                displayTimeLabel.textColor = blue
                ctrlButton.setTitleColor(blue, forState: .Normal)
                task.hidden = false
                taskName.text = "Break"
            } else {
                work = true
                diff = workTime
                displayTimeLabel.textColor = green
                ctrlButton.setTitleColor(green, forState: .Normal)
                taskName.text = task.text
                taskName.hidden = false
                task.hidden = true
                showNotification("Work", notifiBody: task.text ?? " ")
            }
            endTime = currentTime + diff + 1
        }
        let minutes = UInt8(diff / 60.0)
        diff -= (NSTimeInterval(minutes) * 60)
        let seconds = UInt8(diff)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        displayTimeLabel.text = "\(strMinutes):\(strSeconds)"
    }
    
    func showNotification(notifiTitle: String, notifiBody: String) {
        let notification = UILocalNotification()
        notification.alertTitle = notifiTitle
        notification.alertBody = notifiBody
        notification.fireDate = NSDate()
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
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
