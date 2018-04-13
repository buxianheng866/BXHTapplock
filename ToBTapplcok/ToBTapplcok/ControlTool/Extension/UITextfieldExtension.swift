//
//  UITextfieldExtension.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import UIKit
extension UITextField {
    
    /*!
     @method
     @abstract 只输入数字 在任何键盘下
     */
    func validateNumberByExp(exp: String) -> Bool {
        var isValid = true
        let length = exp.count
        if length > 0 {
            let numberRegex = "^[0-9]*$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
            isValid = predicate.evaluate(with: exp)
        }
        return isValid
    }
    
}
