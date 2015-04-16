//
//  FFHourAndMinLabelWithLine.swift
//  FFCalendar
//
//  Created by Hive on 4/15/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

class FFHourAndMinLabelWithLine: FFHourAndMinLabel {
    
    // MARK: - Lifecycle
    
    private var viewLine: UIView?
    private var constraintViewLineWidth: NSLayoutConstraint!
    
    override init(date: NSDate!) {
        
        super.init(date: date)
        
        viewLine = UIView()
        self.font = UIFont.systemFontOfSize(isIphone ? 7 : 20)
        
        if let viewLine = viewLine {
            
            viewLine.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(viewLine)
            
            constraintViewLineWidth = NSLayoutConstraint(item: viewLine, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
            self.addConstraint(constraintViewLineWidth)
            self.addConstraint(NSLayoutConstraint(item: viewLine, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: viewLine, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: viewLine, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 1))
        }
        
        self.textColor = UIColor.blackColor()
        showText()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        
        let width = self.frame.size.width-(self.widthThatWouldFit()+10)
        if width>0 { constraintViewLineWidth.constant = self.frame.size.width-(self.widthThatWouldFit()+10) }
        
        self.updateConstraints()
        self.layoutIfNeeded()
    }
    
    // MARK: - Override Property
    
    override var textColor: UIColor! {
        
        didSet {
            if let viewLine = viewLine {
                viewLine.backgroundColor = self.textColor
            }
        }
    }
    
    override var text: String! {
        
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override var font: UIFont! {
        
        didSet {
            self.layoutIfNeeded()
        }
    }
}
