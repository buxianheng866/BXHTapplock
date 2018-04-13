//
//  BLEPeripheral.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/11.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import UIKit
import CoreBluetooth

class BLEPeripheral: NSObject {
    
    var name: String? {
        return self.peripheral.name
    }
    var mac: String?
    var status: CBPeripheralState = .disconnected
    var battery: Int?
    var hardwareVersion: String?
    var firmwareVersion: String?
    var suucess: Bool = false
    
    var fingerprintID: String?
    var key1: String?
    var key2: String?
    var serialNumber: String?
    
    // 工具属性
    //可读Characteristic
    var readCharacteristic: CBCharacteristic?
    //可写Characteristic
    var writeCharacteristic: CBCharacteristic?
    
    var peripheral: CBPeripheral
    
    init(_ peripheral: CBPeripheral) {
        
        self.peripheral = peripheral
        super.init()
        self.peripheral.delegate = self
        
    }
    
    deinit {
        plog("Peripheral销毁了")
    }
}

extension BLEPeripheral: CBPeripheralDelegate {
    
    //接受数据
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        guard let response = BluetoothResponse.init(characteristic.value!) else {
            let none = characteristic.value!.hexadecimal()
            print("未被处理的数据: \(none)")
            return
        }
        
        self.suucess = response.success
        plog(response.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ble_notficationKye), object: response.success, userInfo: nil)
        switch response {
        case .GetDeviceMac:
            self.mac = response.mac
            
            TapplockManager.default.mylockscontainsMac(peripheral: self)
            
        case .PairingRegular:
            self.sendGetFiremwareCommand()
        case .GetFiremwareVersion:
            
            self.hardwareVersion = response.hardVersion
            self.firmwareVersion = response.firemwareVersion
            
            sendBatteryCommand()
            
        case .Battery:
            self.battery = response.battery
            
            switch hardwareVersion! {
            case aKind:
                sendGetHistory()
            case bKind:
                
                sendTimeCommd()
            default:
                plog("老铁啥都不是")
            }
            
        case .GMTTime:
            sendGetHistory()
            
        case .History:
            
            plog("xxx")
            
        case .Booting:
            plog("booting成功")
        
        case .PairingFirstTime:
            if response.success {
                plog("first成功")
                serialNumber = response.serialNumber
            
            } else {
                plog("first失败")
            }
        case .EnrollFingerprint:
              fingerprintID = response.fingerprintID
        
        case .DeleteFingerprint:
            
            if response.success {
                plog("删除成功")
            }
        case .FactoryReset:
            if response.success {
                plog("删除成功")
            }
        
        default:
            plog("老铁,吃了吗")
        }
       
        
    }
    
    // 发现外设
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        onDiscoverServices(peripheral)
    }
    
    // 发现特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        onDiscoverCharacteristics(peripheral, service: service)
    }
}
