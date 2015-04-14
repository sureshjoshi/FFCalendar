//
//  FFHourAndMinLabel.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

class FFHourAndMinLabel: UILabel {
    
    // MARK: - Properties
    
    var dateHourAndMin: NSDate!
    
    // MARK: - Lifecycle
    
    init(date: NSDate!) {
        
        super.init(frame: CGRectZero)
        
        dateHourAndMin = date
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Other Methods
    
    func showText() {
        
        let comp = dateHourAndMin.components()
        self.text = String(format: "%02ld:%02ld", comp.hour, comp.minute)
    }
}
