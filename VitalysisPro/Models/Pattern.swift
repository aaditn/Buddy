//
//  MigraineLog.swift
//  VitalysisPro
//
//  Created by Aadit Noronha on 7/13/24.
//

import Foundation
import SwiftUI

class Pattern {
    var timestamps: [Double]
    var length: Double

    init(timeStamps: [Double], length: Double) {
        self.timestamps = timeStamps
        self.length = length
    }
    static func oneTap() -> Pattern {
        return Pattern(timeStamps: [0], length: 1)
    }
    static func twoTap() -> Pattern {
        return Pattern(timeStamps: [0, 0.2], length: 1)
    }

}
