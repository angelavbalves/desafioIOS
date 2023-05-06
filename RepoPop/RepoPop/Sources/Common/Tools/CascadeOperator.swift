//
//  CascadeOperator.swift
//  RepoPop
//
//  Created by Angela Alves on 08/03/23.
//

import Foundation

prefix operator ..
infix operator ..: MultiplicationPrecedence

@discardableResult
func .. <T>(object: T, configuration: (inout T) -> Void) -> T {
    var object = object
    configuration(&object)
    return object
}
