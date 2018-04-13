//
//  StringExtension.swift
//  Test000
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation

extension String {
    
    
    var length: Int {
        var a = 0
        for _ in self {
            a = a + 1
        }
        return a
    }
    
    //XX:XX:XX:XX => XXXXXXXX
    var macValue: String {
        get {
            var mac = self.replacingOccurrences(of: ":", with: "")
            mac = mac.uppercased()
            return mac
        }
    }
    //XXXXXXXX => XX:XX:XX:XX
    var macText: String {
        get {
            var mac = macValue.inserting(separator: ":", every: 2)
            mac = mac.uppercased()
            return mac
            
        }
    }
    //XXXXXXXX => [XX,XX,XX,XX]
    var pairs: [String] {
        var result: [String] = []
        let characters = Array(self)
        stride(from: 0, to: count, by: 2).forEach {
            result.append(String(characters[$0..<min($0 + 2, count)]))
        }
        return result
    }
    
    mutating func insert(separator: String, every n: Int) {
        self = inserting(separator: separator, every: n)
    }
    
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: count, by: n).forEach {
            result += String(characters[$0..<min($0 + n, count)])
            if $0 + n < count {
                result += separator
            }
        }
        return result
    }
    
    // "02A9BC" 转 16进制data
    func strToHexadecimal() -> Data! {
        var data = Data(capacity: self.count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        guard data.count > 0 else {
            return nil
        }
        return data
    }
    
    // MARK: 16进制转10
    var hexToInt: Int? {
        let str = self.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
    
    // MARK: 2进制转10进制
    var binToDec: Int? {
        var sun: Int = 0
        for c in self {
            let str = String(c)
            sun = sun * 2 + Int(str)!
        }
        return sun
    }
    
    // MARK: 10进制转其他进制
    func hexadeConver(rax: Int = 16) -> String? {
        let sum = Int(self)
        if sum != nil {
            return String(sum!,radix: rax)
        }
        return nil
    }
    
    // MARK: 判断是否是数字
    var isPurnInt: Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    
    // MARK: 从字符串中提取数字
    var getIntFromStr: String? {
        let scanner = Scanner(string: self)
        scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
        var number :Int = 0
        scanner.scanInt(&number)
        return String(number)
    }
    // MARK: 转字符串补0
    func hexadecimalSupplement() -> String {
        if self.length == 1 {
            return "0" + self
        }
        return self
    }
    
    // MARK: 交换
    func exchangeSequence() -> String {
        let front = self[0...1]
        let behind = self[2...3]
        return behind + front
    }
    
    subscript(_ r: CountableRange<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    //[0...3]
    subscript(_ range: CountableClosedRange<Int>) -> String {
        get {
            return self[range.lowerBound..<range.upperBound + 1]
        }
    }
    
    func substring(_ startIndex: Int, length: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.startIndex, offsetBy: startIndex + length)
        return String(self[start..<end])
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.index(self.startIndex, offsetBy: i)
            return self[index]
        }
    }
    
}


//isSimulator,开发时用
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

