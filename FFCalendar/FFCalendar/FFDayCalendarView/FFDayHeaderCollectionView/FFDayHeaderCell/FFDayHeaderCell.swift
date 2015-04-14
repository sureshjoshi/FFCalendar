//
//  FFDayHeaderCell.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

protocol FFDayHeaderCellDelegate {
    
    func cell(cell: UICollectionViewCell, dateSelected date: NSDate)
}

class FFDayHeaderCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var button: FFDayHeaderButton!
    
    var protocolCustom: FFDayHeaderCellDelegate?
    
    var date: NSDate? {
        
        didSet {
            self.button.date = date
            
            if let comp = date?.components() {
                
                self.button?.setTitle(String(format: "%@, %li", k_ARRAY_WEEK_ABREVIATION[comp.weekday-1], comp.day), forState: UIControlState.Normal)
                self.button?.selected = NSDate.isTheSameDateTheCompA(comp, andCompB: FFDateManager.sharedManager.dateCalendar.components())
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    // MARK: - Action
    
    func buttonAction(sender: AnyObject?) {
        
        if let date = button.date {
            protocolCustom?.cell(self, dateSelected: date)
        }
        
        FFDateManager.sharedManager.dateCalendar = button.date
    }
    
    // MARK: - Add Subviews
    
    func addSubviews() {
        
        button = FFDayHeaderButton()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(button)
        
        let k_BUTTON = "button"
        let dictViews = [k_BUTTON: button]
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]-0-|", k_BUTTON), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"V:|-0-[%@]-0-|", k_BUTTON), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        
        self.contentView.layoutIfNeeded()
    }
}
