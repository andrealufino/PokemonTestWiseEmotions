//
//  CustomStringConvertibleExtensions.swift
//  AMLExtensions
//
//  Created by Andrea Mario Lufino on 14/05/2020.
//  Copyright © 2020 Andrea Mario Lufino. All rights reserved.
//

import Foundation


public extension CustomStringConvertible {
    
    var description: String {
        var description: String = "** \(type(of: self)) **\n"
        
        let selfMirror = Mirror(reflecting: self)
        
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        
        description += "<\(Unmanaged.passUnretained(self as AnyObject).toOpaque())>)\n"
        
        return description
    }
}
