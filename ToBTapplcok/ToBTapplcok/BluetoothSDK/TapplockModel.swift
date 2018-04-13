//
//  TapplockModel.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/11.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import UIKit
import CoreBluetooth
import SwiftyJSON
class TapplockModel: NSObject {
    var id: Int? //锁id
    var lockName: String? //锁名字
    var key1: String? //
    var key2: String? //
    var mac: String?  // mac地址
    var oneAccess: String?
    var serialNo: String? //写锁用
    var shareUuid: String? // 分享 -1 为自己
    var imageUrl: String?  //锁图像
    
    // 蓝牙模型
    var peripheral: BLEPeripheral? {
        didSet {
            peripheral?.key1 = self.key1
            peripheral?.key2 = self.key2
            peripheral?.serialNumber = self.serialNo
        }
    }
    override init() {
        
    }
    init(json: JSON) {
        super.init()
        id = json["id"].int
        lockName = json["lockName"].string
        key1 = json["key1"].string
        key2 = json["key2"].string
        mac = json["mac"].string
        oneAccess = json["oneAccess"].string
        serialNo = json["serialNo"].string
        imageUrl = json["imageUrl"].string
        shareUuid = json["shareUuid"].string
    }
    
    deinit {
        plog("tapplockModel销毁了")
    }
}
