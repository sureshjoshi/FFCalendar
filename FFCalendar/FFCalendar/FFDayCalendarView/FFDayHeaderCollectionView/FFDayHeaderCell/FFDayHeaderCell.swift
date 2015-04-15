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
    private var constraintButtonWidth: NSLayoutConstraint!
    
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
        
        self.backgroundColor = UIColor.customGrayLighter()
        
        addSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let padding: CGFloat = 2
        constraintButtonWidth.constant = min(self.frame.size.width-2*padding, self.frame.size.height-2*padding)
        
        self.updateConstraints()
        self.layoutIfNeeded()
        
        button.transformToCircle()
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
        
        self.contentView.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: button, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        
        constraintButtonWidth = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        self.contentView.addConstraint(constraintButtonWidth)
        
        self.contentView.layoutIfNeeded()
    }
}
