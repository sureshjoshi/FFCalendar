//
//  FFCalendarViewController.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

class FFCalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let calendarDayView = FFDayCalendarView()
        calendarDayView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(calendarDayView)
        
        let k_CALENDAR_DAY = "calendarDay"
        let dictViews = [k_CALENDAR_DAY: calendarDayView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]-0-|", k_CALENDAR_DAY), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"V:|-0-[%@]-0-|", k_CALENDAR_DAY), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        
        self.view.layoutIfNeeded()
    }
}
