//
//  Date+Math.swift
//  Janus
//
//  Created by Laurent Gaches on 23/01/2018.
//

import Foundation


extension Date {
    public static var today: Date {
        var calendar = Calendar(identifier: .gregorian)
        if let timezone = TimeZone(secondsFromGMT: 0) {
            calendar.timeZone = timezone
        }
        return calendar.startOfDay(for: Date())
    }

    public func add(components: DateComponents) -> Date {
        return Calendar.current.date(byAdding: components, to: self) ?? self
    }

    public func compare(to date: Date, granularity: Calendar.Component) -> ComparisonResult {
        return Calendar.current.compare(self, to: date, toGranularity: granularity)
    }

    public func isBefore(date: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
        let result = self.compare(to: date, granularity: granularity)
        return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
    }

    public func isAfter(date: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
        let result = self.compare(to: date, granularity: granularity)
        return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
    }

    public func isBetween(date: Date, and date2: Date, orEqual: Bool = false, granularity: Calendar.Component = .nanosecond) -> Bool {
        return self.isAfter(date: date, orEqual: orEqual, granularity: granularity)
            && self.isBefore(date: date2, orEqual: orEqual, granularity: granularity)
    }
}

public extension Int {

    internal func toDateComponents(type: Calendar.Component) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.setValue(self, for: type)
        return dateComponents
    }

    public var seconds: DateComponents {
        return self.toDateComponents(type: .second)
    }

    public var minutes: DateComponents {
        return self.toDateComponents(type: .minute)
    }

    public var hours: DateComponents {
        return self.toDateComponents(type: .hour)
    }

    public var days: DateComponents {
        return self.toDateComponents(type: .day)
    }

    public var weeks: DateComponents {
        return self.toDateComponents(type: .weekOfYear)
    }

    public var months: DateComponents {
        return self.toDateComponents(type: .month)
    }

    public var years: DateComponents {
        return self.toDateComponents(type: .year)
    }
}

public extension DateComponents {
    /// Internal function helper for + and - operators between two `DateComponents`
    ///
    /// - parameter components: components
    /// - parameter multipler:  optional multipler for each component
    ///
    /// - returns: a new `DateComponents` instance
    internal func add(components: DateComponents, multipler: Int = 1) -> DateComponents {
        let lhs = self
        let rhs = components

        var newCmps = DateComponents()
        let flagSet = DateComponents.allComponents
        flagSet.forEach { component in
            let left = lhs.value(for: component)
            let right = rhs.value(for: component)

            if left != nil && right != nil && left != Int(NSDateComponentUndefined) && right != Int(NSDateComponentUndefined) {
                let value = left! + (right! * multipler)
                newCmps.setValue(value, for: component)
            } else {
                if left != nil && left != Int(NSDateComponentUndefined) {
                    newCmps.setValue(left!, for: component)
                }
                if right != nil && right != Int(NSDateComponentUndefined) {
                    newCmps.setValue(right!, for: component)
                }
            }
        }
        return newCmps
    }

    /// Define a list of all calendar components as array
    internal static let allComponents: [Calendar.Component] =  [.nanosecond, .second, .minute, .hour, .day, .month, .year, .yearForWeekOfYear,
                                                                .weekOfYear, .weekday, .quarter, .weekdayOrdinal, .weekOfMonth]
}

