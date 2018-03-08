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
            var matchingComponents = DateComponents()
            matchingComponents.weekday = 0 // Sunday
            
            let comingSunday =  Calendar.current.nextDate(after: alarm.fireDate!,
                                                          matching: matchingComponents,
                                                          matchingPolicy:.nextTime)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingSunday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isMonOn)
        {
            var matchingComponents = DateComponents()
            matchingComponents.weekday = 1 // Monday
            
            let comingMonday =  Calendar.current.nextDate(after: alarm.fireDate!,
                                                          matching: matchingComponents,
                                                          matchingPolicy:.nextTime)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingMonday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isTueOn)
        {
            var matchingComponents = DateComponents()
            matchingComponents.weekday = 2 // Tuesday
            
            let comingTuesday =  Calendar.current.nextDate(after: alarm.fireDate!,
                                                           matching: matchingComponents,
                                                           matchingPolicy:.nextTime)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingTuesday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isWedOn)
        {
            var matchingComponents = DateComponents()
            matchingComponents.weekday = 3 // Wednesday
            
            let comingWednesday =  Calendar.current.nextDate(after: alarm.fireDate!,
                                                             matching: matchingComponents,
                                                             matchingPolicy:.nextTime)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingWednesday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isThuOn)
        {
            var matchingComponents = DateComponents()
            matchingComponents.weekday = 4 // Thrusday
            
            let comingThursday =  Calendar.current.nextDate(after: alarm.fireDate!,
                                                            matching: matchingComponents,
                                                            matchingPolicy:.nextTime)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingThursday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isFriOn)
        {
            var matchingComponents = DateComponents()
            matchingComponents.weekday = 5 // Friday
            
            let comingFriday =  Calendar.current.nextDate(after: alarm.fireDate!,
                                                          matching: matchingComponents,
                                                          matchingPolicy:.nextTime)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingFriday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Unable to add notification request, \(error.localizedDescription)")
                }
            }
        }
        
        if(alarm.isSatOn)
        {
            var matchingComponents = DateComponents()
            matchingComponents.weekday = 6 // Saturday
            
            let comingSaturday =  Calendar.current.nextDate(after: alarm.fireDate!,
                                                            matching: matchingComponents,
                                                            matchingPolicy:.nextTime)
            let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: comingSaturday!)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: alarm.repeatAlarm)
            
            let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
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
}
