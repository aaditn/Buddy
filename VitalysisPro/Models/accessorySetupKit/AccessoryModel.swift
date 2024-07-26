//
//  AccessoryModel.swift
//  Flex
//

import Foundation
import CoreBluetooth
import UIKit

enum AccessoryModel {
    case buddy
    
    var accessoryName: String {
        switch self {
            case .buddy: "Buddy"
        }
    }
    
    var displayName: String {
        switch self {
            case .buddy: "Buddy"
        }
    }
    
    var serviceUUID: CBUUID {
        switch self {
            case .buddy: CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
        }
    }
    
    var accessoryImage: UIImage {
        switch self {
            case .buddy: .render1
        }
    }
}
