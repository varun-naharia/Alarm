//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by James Pacheco on 5/6/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
            let timeIntervalSinceMidnight = alarmDatePicker.date.timeIntervalSince(thisMorningAtMidnight)
            if let alarm = alarm {
                AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title, isRepeatOn: isRepeatOn, isSunOn: isSunOn, isMonOn: isMonOn, isTueOn: isTueOn, isWedOn: isWedOn, isThuOn: isThuOn, isFriOn: isFriOn, isSatOn: isSatOn)
                cancelUserNotifications(for: alarm)
                scheduleUserNotifications(for: alarm)
            } else {
                let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title, isRepeatOn: isRepeatOn, isSunOn: isSunOn, isMonOn: isMonOn, isTueOn: isTueOn, isWedOn: isWedOn, isThuOn: isThuOn, isFriOn: isFriOn, isSatOn: isSatOn)
                self.alarm = alarm
                scheduleUserNotifications(for: alarm)
            }
        
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func addAlarmFor(date:Date, title:String, thisMorningAtMidnight:Date, repeatAlarm:Bool) {
       
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        updateViews()
    }
    
    // MARK: Private
    
    private func updateViews() {
        guard let alarm = alarm,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight,
            isViewLoaded else {
                enableButton.isHidden = true
                return
        }
        
        alarmDatePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        alarmTitleTextField.text = alarm.name
        
        enableButton.isHidden = false
        if alarm.enabled {
            enableButton.setTitle("Disable", for: UIControlState())
            enableButton.setTitleColor(.white, for: UIControlState())
            enableButton.backgroundColor = .red
        } else {
            enableButton.setTitle("Enable", for: UIControlState())
            enableButton.setTitleColor(.blue, for: UIControlState())
            enableButton.backgroundColor = .gray
        }
        
        isSunOn = alarm.isSunOn
        sunButton.backgroundColor = isSunOn ? UIColor.blue : UIColor.red
        isMonOn = alarm.isMonOn
        monButton.backgroundColor = isMonOn ? UIColor.blue : UIColor.red
        isTueOn = alarm.isTueOn
        tueButton.backgroundColor = isTueOn ? UIColor.blue : UIColor.red
        isWedOn = alarm.isWedOn
        wedButton.backgroundColor = isWedOn ? UIColor.blue : UIColor.red
        isThuOn = alarm.isThuOn
        thuButton.backgroundColor = isThuOn ? UIColor.blue : UIColor.red
        isFriOn = alarm.isFriOn
        friButton.backgroundColor = isFriOn ? UIColor.blue : UIColor.red
        isSatOn = alarm.isSatOn
        satButton.backgroundColor = isSatOn ? UIColor.blue : UIColor.red
        isRepeatOn = alarm.repeatAlarm
        
        
        
        self.title = alarm.name
    }
    
    // MARK: Properties
    
    var alarm: Alarm? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    @IBOutlet weak var sunButton: UIButton!
    @IBOutlet weak var monButton: UIButton!
    @IBOutlet weak var tueButton: UIButton!
    @IBOutlet weak var wedButton: UIButton!
    @IBOutlet weak var thuButton: UIButton!
    @IBOutlet weak var friButton: UIButton!
    @IBOutlet weak var satButton: UIButton!
    
    var isSunOn:Bool = false
    var isMonOn:Bool = false
    var isTueOn:Bool = false
    var isWedOn:Bool = false
    var isThuOn:Bool = false
    var isFriOn:Bool = false
    var isSatOn:Bool = false
    var isRepeatOn:Bool = false
    
    @IBAction func sunButtonTapped(_ sender: Any) {
        isSunOn = !isSunOn
        sunButton.backgroundColor = isSunOn ? UIColor.blue : UIColor.red
    }
    
    @IBAction func monButtonTapped(_ sender: Any) {
        isMonOn = !isMonOn
        monButton.backgroundColor = isMonOn ? UIColor.blue : UIColor.red
    }
    
    @IBAction func tueButtonTapped(_ sender: Any) {
        isTueOn = !isTueOn
        tueButton.backgroundColor = isTueOn ? UIColor.blue : UIColor.red
    }
    
    @IBAction func wedButtonTapped(_ sender: Any) {
        isWedOn = !isWedOn
        wedButton.backgroundColor = isWedOn ? UIColor.blue : UIColor.red
    }
    
    @IBAction func thuButtonTapped(_ sender: Any) {
        isThuOn = !isThuOn
        thuButton.backgroundColor = isThuOn ? UIColor.blue : UIColor.red
    }
    
    @IBAction func friButtonTapped(_ sender: Any) {
        isFriOn = !isFriOn
        friButton.backgroundColor = isFriOn ? UIColor.blue : UIColor.red
    }
    
    @IBAction func satButtonTapped(_ sender: Any) {
        isSatOn = !isSatOn
        satButton.backgroundColor = isSatOn ? UIColor.blue : UIColor.red
    }
    
    @IBAction func repeatAction(_ sender: UISwitch) {
            isRepeatOn = sender.isOn
    }
    
    
}
