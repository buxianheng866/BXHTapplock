//
//  UIIViewControllerExtension.swift
//  ToBTapplcok
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
import UIKit
import CFAlertViewController
extension UIViewController {
    func showToast(message: String, didDismiss: ((Any) -> Void)? = nil) {
//        let alertController = CFAlertViewController(title: message,
//                                                    message: nil,
//                                                    textAlignment: .left,
//                                                    preferredStyle: .alert,
//                                                    didDismissAlertHandler: nil)
//        alertController.shouldDismissOnBackgroundTap = false
//        alertController.backgroundStyle = .blur
//        alertController.backgroundColor = UIColor.clear
//
//        let okAction = CFAlertAction(title: R.string.localizable.oK(),
//                                     style: .Default,
//                                     alignment: .justified,
//                                     backgroundColor: UIColor.themeColor,
//                                     textColor: nil,
//                                     handler: didDismiss)
//        alertController.addAction(okAction)
//
//        present(alertController, animated: true, completion: nil)
    }

}
