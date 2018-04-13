//
//  ViewController.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model: TapplockModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        Optional("01020304")===Optional("00000000")====Optional("05060708")
        
        model = TapplockModel()
        model.key1 = "01020304"
        model.key2 = "05060708"
        model.serialNo = "00000000"
        model.mac = "5C:B1:E3:31:87:F5"
        TapplockManager.default.my_locks.append(model)
    
        NotificationCenter.default.addObserver(self, selector: #selector(notyfiy(_:)), name: NSNotification.Name(rawValue: ble_notficationKye), object: nil)
        
    }

    @objc func notyfiy(_ notifcation: NSNotification) -> Void {
        let bl = notifcation.object! as! Bool

        plog("====== \(bl)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func connectedAction(_ sender: Any) {
        TapplockManager.default.scan()
    }
    
    @IBAction func disConnected(_ sender: Any) {
        
    }
    
    @IBAction func sendCommand(_ sender: Any) {
        
    }
    
}

