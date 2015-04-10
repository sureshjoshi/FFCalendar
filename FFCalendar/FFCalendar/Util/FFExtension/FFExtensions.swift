//
//  FFExtensions.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

extension NSDate {
    
    class func componentsOfCurrentDate() -> NSDateComponents {
        
        return NSDate.componentsOfDate(NSDate())
    }
    
    class func componentsOfDate(date: NSDate) -> NSDateComponents {
        
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitWeekday | NSCalendarUnit.CalendarUnitWeekOfMonth | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute, fromDate: date)
    }
    
    class func dateWithHour(hour: Int, min: Int) -> NSDate? {
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let comp = NSDate.componentsWithHour(hour, min: min)
        
        return calendar?.dateFromComponents(comp)
    }
    
    class func componentsWithHour(hour: Int, min: Int) -> NSDateComponents {
        
        let comp = NSDateComponents()
        comp.hour = hour
        comp.minute = min
        
        return comp
    }
    
    class func isTheSameDateTheCompA(compA: NSDateComponents, andCompB compB:NSDateComponents) -> Bool {
        
        return compA.day==compB.day && compA.month==compB.month && compA.year==compB.year
    }
}

// MARK: -

extension UIColor {
    
    class func customBlue() -> UIColor {
        
        return UIColor(red: 49/255, green: 181/255, blue: 247/255, alpha: 0.5)
    }
    
    class func customGrayLight() -> UIColor {
        
        return UIColor(white: 0.9, alpha: 1)
    }
}

// MARK: -

//extension UILabel {
//    
//    func widthThatWouldFit() -> CGFloat {
//    
//        self.numberOfLines = 0;
//        var rectText = CGRectZero
//        
//        if let lns_str:NSString = self.text as NSString? {
//            
//            rectText = lns_str.boundingRectWithSize(CGSize(width: CGFloat.max, height: self.frame.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self], context: nil)
//        }
//        
//        return rectText.size.width;
//    }
//}
