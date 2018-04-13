//
//  BLECommand.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
let CDM_PREFIX = "55AA"
let CDM_PassKey = "AE9566C7"
let CMD_GetDeviceMac = CDM_PREFIX + "9A010000"
let CMD_PairingFirstTime = CDM_PREFIX + "81010400"
let CMD_PairingRegular = CDM_PREFIX + "B4010800"
let CMD_Booting = CDM_PREFIX + "92010C00"
let CMD_Battery = CDM_PREFIX + "81030000"
let CMD_Unlock = CDM_PREFIX + "81020000"
let CMD_EnrollFingerprint = CDM_PREFIX + "92020200"
let CMD_DeleteFingerprint = CDM_PREFIX + "45020200"
let CMD_FactoryReset = CDM_PREFIX + "E3010000"
let CMD_MorseCode = CDM_PREFIX + "EB020200"
let CMD_History = CDM_PREFIX + "9A020000"
let CMD_NewHistory = CDM_PREFIX + "9B020000"
let CMD_DFU = CDM_PREFIX + "27010000"
let CMD_GetFirmWareVersion = CDM_PREFIX + "45010000"
let CMD_SendTime = CDM_PREFIX + "10020600"
let CMD_SetDeviceName = CDM_PREFIX + "89010100"
let CMD_SetDeviceNameII = CDM_PREFIX + "8a01"
let CMD_ReadFingerprintImg = CDM_PREFIX + "78020200"
//蓝牙通信指令,参考蓝牙通信文档
enum BluetoothCommand {
    case GetDeviceMac
    case PairingFirstTime
    case PairingRegular(key: String, serialNumber: String)
    case Booting(key1: String, key2: String, serialNumber: String)
    case Battery
    case Unlock
    case EnrollFingerprint
    case DeleteFingerprint(index: String)
    case FactoryReset
    case History
    case NewHistory
    case MorseCode(code: String)
    case DFUModel
    case GetFirmWareVersion
    case SendTime(time: String)
    case SetDeviceName(name: String)
    case SetDeviceNameII()
    case ReadFingerprintImg(index: String)
    var commandString: String {
        switch self {
        case .GetDeviceMac:
            return CMD_GetDeviceMac
        case .PairingFirstTime:
            plog("PairingFirstTime:" + CMD_PairingFirstTime + CDM_PassKey)
            return CMD_PairingFirstTime + CDM_PassKey
        case .PairingRegular(let key, let serialNumber):
            plog("PairingRegular:" + CMD_PairingRegular + key + serialNumber)
            return CMD_PairingRegular + key + serialNumber
        case .Booting(let key1, let key2, let serialNumber):
            plog("Booting:" + CMD_Booting + key1 + key2 + serialNumber)
            return CMD_Booting + key1 + key2 + serialNumber
        case .Unlock:
            return CMD_Unlock
        case .Battery:
            return CMD_Battery
        case .EnrollFingerprint:
            return CMD_EnrollFingerprint
        case .DeleteFingerprint(let index):
            return CMD_DeleteFingerprint + index
        case .FactoryReset:
            plog("FactoryReset:" + CMD_FactoryReset)
            return CMD_FactoryReset
        case .MorseCode(let code):
            return CMD_MorseCode + code
        case .History:
            plog("History:" + CMD_History)
            return CMD_History
        case .NewHistory:
//            plog("NewHistory:" + CMD_NewHistory)
            return CMD_NewHistory
        case .DFUModel:
            return CMD_DFU
        case .GetFirmWareVersion:
            return CMD_GetFirmWareVersion
        case .SendTime(let time):
            return CMD_SendTime + time
        case .SetDeviceName(let name):
            plog("setDeviceName: \(CMD_SetDeviceName + name)")
            return CMD_SetDeviceName + name
        case .SetDeviceNameII():
            return CMD_SetDeviceNameII
        case .ReadFingerprintImg(let index):
            plog("readfingerPrint: \(CMD_ReadFingerprintImg + index)")
            return CMD_ReadFingerprintImg + index
        }
    }
    
    var command: Data {
        switch self {
        default:
            var data = commandString.strToHexadecimal()
            let chechSum = data!.checksum()
            let chechSumData = Data.init(bytes: [chechSum.lowByte(), chechSum.highByte()])
            data?.append(contentsOf: chechSumData)
            return data!
        }
    }
}


