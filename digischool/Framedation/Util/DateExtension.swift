//
//  DateExtension.swift
//  digischool
//
//  Created by Flavien SICARD on 1/22/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import Foundation

public extension Date {
    func convertToString(formatType: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType
        
        let newDate: String = dateFormatter.string(from: self) // pass Date here
        return newDate
    }
    
    func compare(_ other: Date) -> Bool {
        if self == other {
            return true
        }
        return false
    }
    
    func compareDay(_ other: Date) -> Bool {
        if self.convertToString(formatType: "dd/MM/yyyy") == other.convertToString(formatType: "dd/MM/yyyy") {
            return true
        }
        return false
    }
}
