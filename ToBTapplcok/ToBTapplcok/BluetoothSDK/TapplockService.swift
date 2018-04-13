//
//  TapplockService.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/12.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
import CoreBluetooth

let aKind = "0001"
let bKind = "0002"

//截取有数的那位

// 设备类型
enum TapplockType: String {
    case typeA = "0001"
    case typeB = "0100"
    case typeC = "0002"
    case typeD = "0200"
    
    var deviceType: String! {
        switch self {
        case .typeA,.typeB:
            return aKind
        case .typeC,.typeD:
            return bKind
        }
    }
    
}


// 协议
protocol TapplockProtocol {
    // 进入DFU模式
    func startDFU(peripheral: CBPeripheral)
    
}
