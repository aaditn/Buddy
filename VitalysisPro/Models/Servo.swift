//
//  Item.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/13/24.
//

import Foundation
import SwiftData

final class Servo {
 
     var power: Double
     // No relationship attribute needed

    init(power: Double) {
       self.power = power
     }
    func run() {
        
    }
    func idle() {
        // run servo at idle
    }
}
