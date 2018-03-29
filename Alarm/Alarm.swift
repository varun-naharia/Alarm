//
//  Alarm.swift
//  Alarm
//
//  Created by James Pacheco on 5/6/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class Alarm: NSObject, NSCoding {
	private let FireTimeFromMidnightKey = "fireTimeFromMidnight"
	private let NameKey = "name"
	private let EnabledKey = "enabled"
	private let UUIDKey = "UUID"
    var repeatAlarm:Bool = false
    var isSunOn:Bool = false
    var isMonOn:Bool = false
    var isTueOn:Bool = false
    var isWedOn:Bool = false
    var isThuOn:Bool = false
    var isFriOn:Bool = false
    var isSatOn:Bool = false
	
	init(fireTimeFromMidnight: TimeInterval, name: String, enabled: Bool = true, uuid: String = UUID().uuidString) {
		self.fireTimeFromMidnight = fireTimeFromMidnight
		self.name = name
		self.enabled = enabled
		self.uuid = uuid
	}
	
	// MARK: - NSCoding
	
	required init?(coder aDecoder: NSCoder) {

		guard let name = aDecoder.decodeObject(forKey: NameKey) as? String,
			let uuid = aDecoder.decodeObject(forKey: UUIDKey) as? String else { return nil }
		
		self.fireTimeFromMidnight = TimeInterval(aDecoder.decodeDouble(forKey: FireTimeFromMidnightKey))
		self.name = name
		self.enabled = aDecoder.decodeBool(forKey: EnabledKey)
		self.uuid = uuid
        repeatAlarm = aDecoder.decodeBool(forKey: "repeatAlarm")
        isSunOn = aDecoder.decodeBool(forKey: "isSunOn")
        isMonOn = aDecoder.decodeBool(forKey: "isMonOn")
        isTueOn = aDecoder.decodeBool(forKey: "isTueOn")
        isWedOn = aDecoder.decodeBool(forKey: "isWedOn")
        isThuOn = aDecoder.decodeBool(forKey: "isThuOn")
        isFriOn = aDecoder.decodeBool(forKey: "isFriOn")
        isSatOn = aDecoder.decodeBool(forKey: "isSatOn")
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(fireTimeFromMidnight, forKey: FireTimeFromMidnightKey)
		aCoder.encode(name, forKey: NameKey)
		aCoder.encode(enabled, forKey: EnabledKey)
		aCoder.encode(uuid, forKey: UUIDKey)
        
        aCoder.encode(isSunOn, forKey: "isSunOn")
        aCoder.encode(isMonOn, forKey: "isMonOn")
        aCoder.encode(isTueOn, forKey: "isTueOn")
        aCoder.encode(isWedOn, forKey: "isWedOn")
        aCoder.encode(isThuOn, forKey: "isThuOn")
        aCoder.encode(isFriOn, forKey: "isFriOn")
        aCoder.encode(isSatOn, forKey: "isSatOn")
        aCoder.encode(repeatAlarm, forKey: "repeatAlarm")
	}
 
	// MARK: Properties
	
	var fireTimeFromMidnight: TimeInterval
	var name: String
	var enabled: Bool
	let uuid: String
	
	var fireDate: Date? {
		guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return nil }
        let fireTimeInMinutes = Int(fireTimeFromMidnight / 60)
        let fireTimeInSeconds = TimeInterval(fireTimeInMinutes * 60)
		let fireDateFromThisMorning = Date(timeInterval: fireTimeInSeconds, since: thisMorningAtMidnight)
		return fireDateFromThisMorning
	}
	
	var fireTimeAsString: String {
		let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
		var hours = fireTimeFromMidnight/60/60
		let minutes = (fireTimeFromMidnight - (hours*60*60))/60
		if hours >= 13 {
			return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
		} else if hours >= 12 {
			return String(format: "%2d:%02d PM", arguments: [hours, minutes])
		} else {
			if hours == 0 {
				hours = 12
			}
			return String(format: "%2d:%02d AM", arguments: [hours, minutes])
		}
	}
}

// MARK: - Equatable

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
	return lhs.uuid == rhs.uuid
}
