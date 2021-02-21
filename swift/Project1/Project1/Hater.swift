//
//  Hater.swift
//  Project1
//
//  Created by Jinwoo Kim on 2/22/21.
//

import Foundation

struct Hater {
    var hating = false
    
    mutating func hadABadDay() {
        hating = true
    }
    
    mutating func hadAGoodDay() {
        hating = false
    }
}
