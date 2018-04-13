//
//  DataExtension.swift
//  Test000
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation

extension Data {
    func hexadecimal() -> String {
        return map {
            String(format: "%02x", $0)
            }
            .joined(separator: "")
    }
}
extension UInt16 {
    public func highByte() -> UInt8! {
        return UInt8(self >> 8)
    }
    
    public func lowByte() -> UInt8! {
        return UInt8(self & 0xff)
    }
}
