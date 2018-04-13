//
//  DateExtension.swift
//  Test000
//
//  Created by TapplockiOS on 2018/4/10.
//  Copyright © 2018年 TapplockiOS. All rights reserved.
//

import Foundation
extension Date {
    

   static func tampCoverToStringTime(tamp: Int) -> String {
        let timeInterval : TimeInterval = TimeInterval(tamp)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //自定义日期格式
        let time = dateformatter.string(from: date as Date)
        return time
    }
    
    
   static func tampCoveToString(timeStamp: Int,fomatter: String = "yyyy-MM-dd HH:mm:sss") -> String {
        let timeInterval = TimeInterval(timeStamp)
        let date1 = Date(timeIntervalSince1970: timeInterval)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = fomatter //自定义日期格式
        let time = dateformatter.string(from: date1)
        return time
    }
    
   static func stringTimeCoverToTamp(time: String) -> Int {
        let datefmatter = DateFormatter()
        datefmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = datefmatter.date(from: time)
        if date == nil {
            return 1522378147
        }

//        let newdate = MorseCode.getLoacalTime(date!)
        let newdate = NSDate()
        
        let dateStamp:TimeInterval = newdate.timeIntervalSince1970
        let dateStr:Int = Int(dateStamp)
        return dateStr
    }

    


}
