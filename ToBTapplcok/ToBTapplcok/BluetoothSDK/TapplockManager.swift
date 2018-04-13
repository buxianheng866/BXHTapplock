//
//  TapplockManager.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxCocoa
import RxSwift
import NSObject_Rx
let UUID_SERVICE = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
let DFU_SERVICE = "00001530-1212-EFDE-1523-785FEABCD123"
let UUID_Characteristic_SEND = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
let UUID_Characteristic_RECIEVE = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"


final class TapplockManager: NSObject {
    
    static let `default` = TapplockManager()
    
    // 连接过的锁
 
    var rx_mylocks: BehaviorRelay<[TapplockModel]> = BehaviorRelay(value: [TapplockModel]())
    
    // 扫描的设备
    var scan_peripheral = Set<BLEPeripheral>()
    
    var manager: CBCentralManager!
    
    var bluetoothState: CBManagerState {
        return manager.state
    }
    
    
    override init() {
        super.init()
        manager = CBCentralManager.init(delegate: self, queue: DispatchQueue.main)
    }
    
    public func scan() {
        manager.stopScan()
        if manager.state == .poweredOn {
           manager.scanForPeripherals(withServices: [CBUUID.init(string: UUID_SERVICE),CBUUID.init(string: DFU_SERVICE)], options: nil)
        }
    }
    
    public func stop() {
        manager.stopScan()
        for model in self.rx_mylocks.value {
            if let per = model.peripheral {
                manager.cancelPeripheralConnection(per.peripheral)
            }
        }
    }
    //添加扫描到的设备
    public func addPeripheral(peripheral: CBPeripheral) {
        let bleModel = BLEPeripheral.init(peripheral)
        scan_peripheral.insert(bleModel)
    }
    
    // mac地址相同
    public func mylockscontainsMac(peripheral: BLEPeripheral) {
        guard let mac = peripheral.rx_mac.value else {
            return
        }
//        let model = self.rx_mylocks.value.filter({ $0.rx_mac?.macValue == mac.macValue }).first
//        if model != nil {
//            model?.peripheral = peripheral
//            scan_peripheral.remove(peripheral)
//            model?.peripheral?.sendPairingCommand()
//        }
    }
}

extension TapplockManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            plog("蓝牙打开了")
        default:
            break
        }
    }
    
    // MARK:发现设备
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        plog("发现设备")
        if peripheral.name == "TappLock" {
            manager.stopScan()
            
            // MARK: startDFU
            return
        }
        if !self.scan_peripheral.reduce(false, {$0 || $1.peripheral == peripheral}) {
            addPeripheral(peripheral: peripheral)
            manager.connect(peripheral, options: nil)
        }
    }
    
    // MARK: 连接成功
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        plog("连接成功")
        peripheral.discoverServices([CBUUID.init(string: UUID_SERVICE)])
    }
    
    // MARK: 连接断开
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        plog("连接断开")
        for model in scan_peripheral {
            if model.peripheral == peripheral {
                scan_peripheral.remove(model)
            }
        }
        if UIApplication.shared.applicationState == .active {
            scan()
        }
    }
    // MARK: 连接失败
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        plog("连接失败")
        for model in scan_peripheral {
            if model.peripheral == peripheral {
                scan_peripheral.remove(model)
            }
        }
        if UIApplication.shared.applicationState == .active {
            scan()
        }
    }
    
}

