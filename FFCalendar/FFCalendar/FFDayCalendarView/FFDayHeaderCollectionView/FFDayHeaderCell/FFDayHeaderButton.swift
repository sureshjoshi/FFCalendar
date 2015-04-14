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
    static let imageCircleBlack = UIImage(named: k_IMAGE_CIRCLE_BLACK)
    static let imageCircleRed = UIImage(named: k_IMAGE_CIRCLE_RED)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        UIImageView.my_appearanceWhenContainedIn(FFDayHeaderButton.classForCoder()).contentMode = UIViewContentMode.ScaleAspectFit
        
        self.backgroundColor = UIColor.customGrayLighter()
        self.contentMode = UIViewContentMode.ScaleAspectFit
        
        let fontSize: CGFloat = isIphone ? 10 : 20
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
                        self.setBackgroundImage(FFDayHeaderButton.imageCircleRed, forState: UIControlState.Normal)
                    } else {
                        self.setBackgroundImage(FFDayHeaderButton.imageCircleBlack, forState: UIControlState.Normal)
                    }
                    
                } else {
                    
                    if comp.weekday == 1 || comp.weekday == 7 {
                        self.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                    } else {
                        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                    }
                    
                    self.setBackgroundImage(nil, forState: UIControlState.Normal)
                }
            }
        }
    }
}
