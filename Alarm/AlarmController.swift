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
    
    init() {
        loadFromPersistentStorage()
    }
    
    // MARK: Model Controller Methods
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
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

            let comingSunday =  findNext("Sunday", afterDate: fireDate)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingSunday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

            let request = UNNotificationRequest(identifier: "\(alarm.uuid)0", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }

        if(alarm.isMonOn)
        {
            // Monday

            let comingMonday =  findNext("Monday", afterDate: fireDate)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingMonday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

            let request = UNNotificationRequest(identifier: "\(alarm.uuid)1", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }

        if(alarm.isTueOn)
        {
            // Tuesday

            let comingTuesday =  findNext("Tuesday", afterDate: fireDate)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingTuesday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

            let request = UNNotificationRequest(identifier: "\(alarm.uuid)2", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }

        if(alarm.isWedOn)
        {
            // Wednesday

            let comingWednesday =  findNext("Wednesday", afterDate: fireDate)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingWednesday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

            let request = UNNotificationRequest(identifier: "\(alarm.uuid)3", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }

        if(alarm.isThuOn)
        {
            // Thrusday

            let comingThursday =  findNext("Thrusday", afterDate: fireDate)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingThursday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

            let request = UNNotificationRequest(identifier: "\(alarm.uuid)4", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isFriOn)
        {
            // Friday
            
            let comingFriday =  findNext("Friday", afterDate: fireDate)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingFriday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: "\(alarm.uuid)5", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isSatOn)
        {
             // Saturday

            let comingSaturday = findNext("Saturday", afterDate: fireDate)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingSaturday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)

            let request = UNNotificationRequest(identifier: "\(alarm.uuid)6", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    func findNext(_ day: String, afterDate date: Date) -> Date? {
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
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
        return nextDay!
    }
}
