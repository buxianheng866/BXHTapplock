//
//  BLEResponse.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
let RCM_PREFIX = "AA55"
let RCM_GetDeviceMac = RCM_PREFIX + "9A01"
let RCM_PairingFirstTime = RCM_PREFIX + "8101"
let RCM_Booting = RCM_PREFIX + "9201"
let RCM_PairingRegular = RCM_PREFIX + "B401"
let RCM_Battery = RCM_PREFIX + "8103"
let RCM_EnrollFingerprint = RCM_PREFIX + "9202"
let RCM_DeleteFingerprint = RCM_PREFIX + "4502"
let RCM_FactoryReset = RCM_PREFIX + "E301"
let RCM_MorseCode = RCM_PREFIX + "EB02"
let RCM_History = RCM_PREFIX + "D0"
let RCM_GetFirmwareVersion = RCM_PREFIX + "4501"
let RCM_GMTTime = RCM_PREFIX + "1002"
let RCM_SetDeviceName = RCM_PREFIX + "8901"
let RCM_ReadFingerprintImg = RCM_PREFIX + "7802"

//蓝牙通信响应,参考蓝牙通信文档
enum BluetoothResponse {
    case NoResponse
    case PairingFirstTime(value: String)
    case Booting(value: String)
    case PairingRegular(value: String)
    case GetDeviceMac(value: String)
    case Battery(value: String)
    case EnrollFingerprint(value: String)
    case DeleteFingerprint(value: String)
    case FactoryReset(value: String)
    case MorseCode(value: String)
    case History(value: String)
    case GetFiremwareVersion(value: String)
    case GMTTime(value: String)
    case SetDeviceName(value: String)
    case ReadFingerprint(value: String)
    
    typealias RawValue = String
    var rawValue: RawValue {
        switch self {
        case .NoResponse:
            return ""
        case .PairingFirstTime(let value),
             .GetDeviceMac(let value),
             .Booting(let value),
             .PairingRegular(let value),
             .Battery(let value),
             .EnrollFingerprint(let value),
             .FactoryReset(let value),
             .MorseCode(let value),
             .DeleteFingerprint(let value),
             .History(let value),
             .GetFiremwareVersion(let value),
             .ReadFingerprint(let value),
             .GMTTime(let value),
             .SetDeviceName(let value):
            return value
        }
    }
    
    init?(_ data: Data) {
        let response = data.hexadecimal()
        let index = response.index(response.startIndex, offsetBy: 7)
        let cmd: String = String(response[...index])
        
        if (cmd.uppercased().contains(RCM_History)) {
            self = .History(value: response)
            return
        }
        switch cmd.uppercased() {
        case RCM_PairingFirstTime:
            print("RCM_PairingFirstTime:" + response)
            self = .PairingFirstTime(value: response)
        case RCM_GetDeviceMac:
            print("RCM_GetDeviceMac:" + response)
            self = .GetDeviceMac(value: response)
        case RCM_Booting:
            print("RCM_Booting:" + response)
            self = .Booting(value: response)
        case RCM_PairingRegular:
            print("RCM_PairingRegular:" + response)
            self = .PairingRegular(value: response)
        case RCM_Battery:
            print("RCM_Battery:" + response)
            self = .Battery(value: response)
        case RCM_EnrollFingerprint:
            print("RCM_EbrollFinger:" + response)
            self = .EnrollFingerprint(value: response)
        case RCM_DeleteFingerprint:
            print("RCM_DeleteFingerprint:" + response)
            self = .DeleteFingerprint(value: response)
        case RCM_FactoryReset:
            print("RCM_FactoryReset:" + response)
            self = .FactoryReset(value: response)
        case RCM_MorseCode:
            print("RCM_MorseCode:" + response)
            self = .MorseCode(value: response)
        case RCM_GetFirmwareVersion:
            print("RCM_GetFirmwareVersion:" + response)
            
            self = .GetFiremwareVersion(value: response)
        case RCM_GMTTime:
            print("已经sendGMT时间: \(response)")
            
            self = .GMTTime(value: response)
        case RCM_SetDeviceName:
            print("设置名字返回: \(response)")
            self = .SetDeviceName(value: response)
        case RCM_ReadFingerprintImg:
            print("返回指纹图像\(response)")
            self = .ReadFingerprint(value: response)
        default:
            return nil
        }
    }
    
    
    var firemwareVersion: String?  {
        switch self {
        case .GetFiremwareVersion:
            
            if self.value == nil {
                return "1000"
            }
            let fm = self.rawValue[18...21]
            let val = self.rawValue[14...17]
            if val != "0001" && val != "0002"{
                return fm.exchangeSequence()
            }
            return val
        default:
            return nil
        }
    }
    
    var hardVersion: String?  {
        switch self {
        case .GetFiremwareVersion:
            if self.value == nil {
                return aKind
            }
            let val = TapplockType(rawValue: (self.value?[0...3])!)
            return val?.deviceType
        default:
            return nil
        }
    }
    
    var mac: String? {
        switch self {
        case .GetDeviceMac:
            return self.value
        default:
            return nil
        }
    }
    
    var serialNumber: String? {
        switch self {
        case .PairingFirstTime:
            return self.value?.substring(0, length: 8)
        default:
            return nil
        }
    }
    
    var isNewLock: Bool? {
        switch self {
        case .PairingFirstTime:
            return self.success
        default:
            return nil
        }
    }
    
    var battery: Int? {
        switch self {
        case .Battery:
            return (self.success ? self.value?.hexToInt : nil)
        default:
            return nil
        }
    }
    
    var success: Bool {
        switch self {
        case .History:
            return true
        default:do {
           
            let startIndex = self.rawValue.index((self.rawValue.startIndex), offsetBy: 12)
            let endIndex = self.rawValue.index((self.rawValue.startIndex), offsetBy: 13)
            return String(self.rawValue[startIndex...endIndex]) == "01"
            }
        }
    }
    
    var fingerprintID: String? {
        switch self {
        case .EnrollFingerprint(_):
            return (self.success ? self.value : nil)
        default:
            return nil
        }
    }
    
    func getHistory(_ version: String) -> [Any]? {
        var arr = [Any]()
        
        switch version {
        case aKind:
            let str = self.value?.inserting(separator: ",", every: 4)
            let strArray = str?.components(separatedBy: ",")
            return strArray!
        case bKind:
            if self.value != nil {
                let index = self.value![0...3]
                let open = self.value![4...13]
                let close = self.value![14...23]
                let openTime = hexCovertoTamp(time: open)
                let closeTime = hexCovertoTamp(time: close)
                
                let dict = ["closeTime" : closeTime,"openTime" : openTime,"fingerIndex" : index] as [String : Any]
                arr.append(dict)
                return arr
            }
        default:
            plog("nonting")
            
        }
        return nil
    }
    var history: Array<Any>? {
        switch self {
        case .History(_):
            
          
            
            return nil
        default:
            return nil
        }
        
    }
    
    var value: String? {
        switch self {
        case .History(_):
            
            let startIndex = self.rawValue.index((self.rawValue.startIndex), offsetBy: 12)
            let endIndex = self.rawValue.index(self.rawValue.startIndex, offsetBy: (self.rawValue.count) - 5)
            if startIndex >= endIndex {
                return nil
            } else {
                return String(self.rawValue[startIndex...endIndex])
            }
        default:
            let startIndex = self.rawValue.index((self.rawValue.startIndex), offsetBy: 14)
            let endIndex = self.rawValue.index(self.rawValue.startIndex, offsetBy: (self.rawValue.count) - 5)
            if startIndex >= endIndex {
                return nil
            } else {
                return String(self.rawValue[startIndex...endIndex])
            }
        }
    }
    
    
}

