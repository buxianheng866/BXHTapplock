//
//  PeripheralState.swift
//  Test000
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
import CoreBluetooth

// 多语言
extension CBPeripheralState {
    var textValue: String {
        switch self {
        case .connected:
            return "conect"
        default:
            return "dis"
        }
    }
    
}
