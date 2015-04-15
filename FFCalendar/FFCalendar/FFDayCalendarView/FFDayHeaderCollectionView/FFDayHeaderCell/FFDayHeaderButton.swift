//
//  FFDayHeaderButton.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit



class FFDayHeaderButton: UIButton {
    
    // MARK: - Properties
    
    var date: NSDate?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.contentMode = UIViewContentMode.ScaleAspectFit
        
        let fontSize: CGFloat = isIphone ? 7 : 20
        self.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - Set Public Property
    
    override var selected: Bool {
        
        didSet {
            
            if let comp = date?.components() {
                
                if selected {
                    
                    self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                    
                    if NSDate.isTheSameDateTheCompA(comp, andCompB: NSDate.componentsOfCurrentDate()) {
                        self.backgroundColor = UIColor.redColor()
                    } else {
                        self.backgroundColor = UIColor.blackColor()
                    }
                    
                } else {
                    
                    if comp.weekday == 1 || comp.weekday == 7 {
                        self.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                    } else {
                        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                    }
                    
                    self.backgroundColor = UIColor.clearColor()
                }
            }
        }
    }
}
