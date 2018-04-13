//
//  UIViewExtension.swift
//  Test000
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import UIKit
extension UIView {
    //Storyboard用
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    //Storyboard用
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    //Storyboard用
    @IBInspectable var borderColorFromUIColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var f = self.frame
            f.origin.x = newValue
            self.frame = f
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var f = self.frame
            f.origin.y = newValue
            self.frame = f
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var f = self.frame
            f.size.width = newValue
            self.frame = f
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var f = self.frame
            f.size.height = newValue
            self.frame = f
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.x = newValue.x
            self.y = newValue.y
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    public var rightX: CGFloat {
        get {
            return self.x + self.width
        }
        set {
            var f = self.frame
            f.origin.x = newValue - self.width
            self.frame = f
        }
    }
    
    public var bottomY: CGFloat {
        get {
            return self.y + self.height
        }
        set {
            var f = self.frame
            f.origin.y = newValue - self.height
            self.frame = f
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.centerX, y: newValue)
        }
    }
    
}
