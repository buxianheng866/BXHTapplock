//
//  BLEPeripheralService.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/12.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
import CoreBluetooth
extension BLEPeripheral {
    
    
    public func sendGetDeviceMacCommand() {
        plog("发送获取MAC地址")
        if writeCharacteristic != nil {
            peripheral.writeValue(BluetoothCommand.GetDeviceMac.command, for: writeCharacteristic!, type: .withResponse)
        }
    }
    
    func sendEnterIntoDFU() -> Void {
        guard writeCharacteristic != nil else {
            return
        }
        peripheral.writeValue(BluetoothCommand.DFUModel.command, for: writeCharacteristic!, type: .withResponse)
    }
    
    func sendGetFiremwareCommand() -> Void {
        plog("发送获取固件版本")
        guard writeCharacteristic != nil else {
            return
        }
        peripheral.writeValue(BluetoothCommand.GetFirmWareVersion.command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendBatteryCommand() {
        plog("发送电量")
        peripheral.writeValue(BluetoothCommand.Battery.command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendPairingFirstTimeCommand() {
        plog("发送第一次连接")
        peripheral.writeValue(BluetoothCommand.PairingFirstTime.command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendRestCommand() {
        plog("发重置指令")
        peripheral.writeValue(BluetoothCommand.FactoryReset.command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendPairingCommand() {
        guard let key = key1 else {
            return
        }
        guard let seria = serialNumber else {
            return
        }
        plog("发送配对连接")
        peripheral.writeValue(BluetoothCommand.PairingRegular(key: key, serialNumber: seria).command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendMorseCodeCommand(code: String) {
        plog("发送获MorseCode")
        peripheral.writeValue(BluetoothCommand.MorseCode(code: code).command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendBootCommand() {
        guard let key = key1 else {
            return
        }
        guard let seria = serialNumber else {
            return
        }
        guard let key2 = key2 else {
            return
        }
        plog("发送获Botting")
        peripheral.writeValue(BluetoothCommand.Booting(key1: key, key2: key2, serialNumber: seria).command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendUnlockCommand() {
        peripheral.writeValue(BluetoothCommand.Unlock.command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendEnrollCommand() {
        peripheral.writeValue(BluetoothCommand.EnrollFingerprint.command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendDeleteFingerprintCommand(index: String!) {
        peripheral.writeValue(BluetoothCommand.DeleteFingerprint(index: index).command, for: writeCharacteristic!, type: .withResponse)
    }
    
    public func sendTimeCommd(){
        if writeCharacteristic != nil {
            let times = GMTCoverToHex()
            peripheral.writeValue(BluetoothCommand.SendTime(time: times).command, for: writeCharacteristic!, type: .withResponse)
            
        }
    }
    
    public func sendGetHistory() {
        plog("发送获取历史记录")
        let type = self.hardwareVersion
        guard let tp = type else {
            return
        }
        if tp == aKind {
            peripheral.writeValue(BluetoothCommand.History.command, for: writeCharacteristic!, type: .withResponse)
        }
        if tp == bKind {
            peripheral.writeValue(BluetoothCommand.NewHistory.command, for: writeCharacteristic!, type: .withResponse)
        }
    }
    func sendSetDeviceName(name: String) {
        plog("发送设置设备名称")
        guard writeCharacteristic != nil else {
            return
        }
        let new = name.data(using: .utf8)
        let xm = new?.hexadecimal()
        peripheral.writeValue(BluetoothCommand.SetDeviceName(name: xm!).command, for: writeCharacteristic!, type: .withResponse)
        
        peripheral.writeValue(BluetoothCommand.SetDeviceNameII().command, for: writeCharacteristic!, type: .withResponse)
    }
    
    func sendReadPrintfingerImg(index: String) -> Void {
        plog("发送获取指纹图像")
        peripheral.writeValue(BluetoothCommand.ReadFingerprintImg(index: index).command, for: writeCharacteristic!, type: .withResponse)
    }
    
    
    
    
    // MARK: 搜索服务
    public func onDiscoverServices(_ peripheral: CBPeripheral) {
        for service in peripheral.services! {
            if service.uuid.uuidString == UUID_SERVICE {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    // MARK: 搜索特征
    public func onDiscoverCharacteristics(_ peripheral: CBPeripheral, service: CBService) {
        
        for characteristic in service.characteristics! {
            switch characteristic.uuid.uuidString {
            case UUID_Characteristic_SEND:
                writeCharacteristic = characteristic
                sendGetDeviceMacCommand()
                break
            case UUID_Characteristic_RECIEVE:
                readCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
                break
            default:
                break
            }
        }
    }
}

