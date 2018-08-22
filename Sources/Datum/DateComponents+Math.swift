//
//  DateComponents+Math.swift
//  Datum
//
//  Created by Laurent Gaches on 25/01/2018.
//

import Foundation

public func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
    return lhs.add(components: rhs, multipler: -1)
}

public prefix func - (dateComponents: DateComponents) -> DateComponents {
    var invertedCmps = DateComponents()

    DateComponents.allComponents.forEach { component in
        let value = dateComponents.value(for: component)
        if value != nil && value != Int(NSDateComponentUndefined) {
            invertedCmps.setValue(-value!, for: component)
        }
    }
    return invertedCmps
}

