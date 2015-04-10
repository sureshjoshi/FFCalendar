//
//  FFBlueButton.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

class FFBlueButton: UIButton {
    
    // MARK: - Properties
    
    var event: FFEvent?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backgroundColor = UIColor.customBlue()
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
