//
//  AlarmController.swift
//  Alarm
//
//  Created by James Pacheco on 5/9/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmController {
    
    static let shared = AlarmController()
    var alarmDuration:Int = 30
    
    init() {
        loadFromPersistentStorage()
    }
    
    // MARK: Model Controller Methods
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String, isRepeatOn:Bool, isSunOn:Bool, isMonOn:Bool, isTueOn:Bool, isWedOn:Bool, isThuOn:Bool, isFriOn:Bool, isSatOn:Bool) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarm.isSunOn = isSunOn
        alarm.isMonOn = isMonOn
        alarm.isTueOn = isTueOn
        alarm.isWedOn = isWedOn
        alarm.isThuOn = isThuOn
        alarm.isFriOn = isFriOn
        alarm.isSatOn = isSatOn
        alarm.repeatAlarm = isRepeatOn
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String, isRepeatOn:Bool, isSunOn:Bool, isMonOn:Bool, isTueOn:Bool, isWedOn:Bool, isThuOn:Bool, isFriOn:Bool, isSatOn:Bool) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        alarm.isSunOn = isSunOn
        alarm.isMonOn = isMonOn
        alarm.isTueOn = isTueOn
        alarm.isWedOn = isWedOn
        alarm.isThuOn = isThuOn
        alarm.isFriOn = isFriOn
        alarm.isSatOn = isSatOn
        alarm.repeatAlarm = isRepeatOn
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
    }
    
    // MARK: Load/Save
    
    private func saveToPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath)
    }
    
    private func loadFromPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Alarm] else { return }
        self.alarms = alarms
    }
    
    // MARK: Helpers
    
    static private var persistentAlarmsFilePath: String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Alarms.plist")
    }
    
    // MARK: Properties
    
    var alarms: [Alarm] = []

}

// MARK: - AlarmScheduler

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Time's up!"
        notificationContent.body = "Your alarm titled \(alarm.name) is done"
        notificationContent.sound = UNNotificationSound.default()
        
        guard let fireDate = alarm.fireDate else { return }
        if(alarm.isSunOn)
        {
           // Sunday
            for item in 0...AlarmController.shared.alarmDuration
            {
                let comingSunday =  findNext("Sunday", afterDate: fireDate.adding(minutes: item))
                let triggerDate = Calendar.current.dateComponents([ .year, .month, .weekday, .hour, .minute, .second], from: comingSunday!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

                let request = UNNotificationRequest(identifier: "\(alarm.uuid)0\(item)", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Unable to add notification request, \(error.localizedDescription)")
                    }
                }
            }
        }

        if(alarm.isMonOn)
        {
            // Monday
            for item in 0...AlarmController.shared.alarmDuration
            {
                let comingMonday =  findNext("Monday", afterDate: fireDate.adding(minutes: item))
                let triggerDate = Calendar.current.dateComponents([ .year, .month, .weekday, .hour, .minute, .second], from: comingMonday!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
                
                let request = UNNotificationRequest(identifier: "\(alarm.uuid)1\(item)", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Unable to add notification request, \(error.localizedDescription)")
                    }
                }
            }
        }

        if(alarm.isTueOn)
        {
            // Tuesday
            for item in 0...AlarmController.shared.alarmDuration
            {
                let comingTuesday =  findNext("Tuesday", afterDate: fireDate.adding(minutes: item))
                let triggerDate = Calendar.current.dateComponents([ .year, .month, .weekday, .hour, .minute, .second], from: comingTuesday!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

                let request = UNNotificationRequest(identifier: "\(alarm.uuid)2\(item)", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Unable to add notification request, \(error.localizedDescription)")
                    }
                }
            }
        }

        if(alarm.isWedOn)
        {
            // Wednesday
            for item in 0...AlarmController.shared.alarmDuration
            {
                let comingWednesday =  findNext("Wednesday", afterDate: fireDate.adding(minutes: item))
                let triggerDate = Calendar.current.dateComponents([ .year, .month, .weekday, .hour, .minute, .second], from: comingWednesday!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

                let request = UNNotificationRequest(identifier: "\(alarm.uuid)3\(item)", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Unable to add notification request, \(error.localizedDescription)")
                    }
                }
            }
        }

        if(alarm.isThuOn)
        {
            // Thrusday
            for item in 0...AlarmController.shared.alarmDuration
            {
                let comingThursday =  findNext("Thursday", afterDate: fireDate.adding(minutes: item))
                let triggerDate = Calendar.current.dateComponents([ .year, .month, .weekday, .hour, .minute, .second], from: comingThursday!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

                let request = UNNotificationRequest(identifier: "\(alarm.uuid)4\(item)", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Unable to add notification request, \(error.localizedDescription)")
                    }
                }
            }
        }
        
        if(alarm.isFriOn)
        {
            // Friday
            
            for item in 0...AlarmController.shared.alarmDuration
            {
                let comingFriday =  findNext("Friday", afterDate: fireDate.adding(minutes: item))
                let triggerDate = Calendar.current.dateComponents([ .year, .month, .weekday, .hour, .minute, .second], from: comingFriday!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
                
                let request = UNNotificationRequest(identifier: "\(alarm.uuid)5\(item)", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Unable to add notification request, \(error.localizedDescription)")
                    }
                }
            }
        }
        
        if(alarm.isSatOn)
        {
             // Saturday
            for item in 0...AlarmController.shared.alarmDuration
            {
                let comingSaturday = findNext("Saturday", afterDate: fireDate.adding(minutes: item))
                let triggerDate = Calendar.current.dateComponents([ .year, .month, .weekday, .hour, .minute, .second], from: comingSaturday!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

                let request = UNNotificationRequest(identifier: "\(alarm.uuid)6\(item)", content: notificationContent, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Unable to add notification request, \(error.localizedDescription)")
                    }
                }
            }
        }
        
        
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    func findNext(_ day: String, afterDate date: Date) -> Date? {
        
        var calendar = Calendar.current
        calendar.timeZone = .current

//        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        let weekDaySymbols = calendar.weekdaySymbols
        let indexOfDay = weekDaySymbols.index(of: day)
        
        assert(indexOfDay != nil, "day passed should be one of \(weekDaySymbols), invalid day: \(day)")
        
        let weekDay = indexOfDay! + 1
        
        let components = calendar.component(.weekday, from: date)
        
        if components == weekDay {
            return date
        }
        
        var matchingComponents = DateComponents()
        matchingComponents.weekday = weekDay // Monday
        
        let nextDay = calendar.nextDate(after: date,
                                        matching: matchingComponents,
                                        matchingPolicy:.nextTime)
        let timeToAdd = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        
        var nextDayWithTime = Calendar.current.date(byAdding: .hour, value: timeToAdd.hour!, to: nextDay!)!
        nextDayWithTime = Calendar.current.date(byAdding: .minute, value: timeToAdd.minute!, to: nextDayWithTime)!
        
        
        return nextDayWithTime
    }
}

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
