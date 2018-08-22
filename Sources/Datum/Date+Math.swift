//
//  Date+Math.swift
//  Datum
//
//  Created by Laurent Gaches on 25/01/2018.
//

import Foundation

public func + (lhs: Date, rhs: DateComponents) -> Date {
    return lhs.add(components: rhs)
}

public func - (lhs: Date, rhs: DateComponents) -> Date {
    return lhs + (-rhs)
}
