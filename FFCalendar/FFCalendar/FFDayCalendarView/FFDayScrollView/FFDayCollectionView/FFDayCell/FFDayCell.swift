//
//  FFDayCell.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

protocol FFDayCellProtocol {
    
    func cell(cell: UICollectionViewCell, showViewDetailsWithEvent event: FFEvent?)
}

class FFDayCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var protocolCustom: FFDayCellProtocol?
    var date: NSDate? {
        
        didSet {
            
            self.reloadLabelRed()
        }
    }
    
    private var arrayLabelsHourAndMin: Array<FFHourAndMinLabel>! = []
    private var arrayButtonsEvents: Array<FFBlueButton>! = []
    private var button: FFBlueButton?
    private var yCurrent: Float?
    private var labelRed: FFHourAndMinLabel!
    private var arrayConstraintsLabelRed: Array<AnyObject>?
    private var labelBottomLabelRed: FFHourAndMinLabel?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addLines()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Add Lines
    
    private func addLines() {
        
        let compNow = NSDate.componentsOfCurrentDate()
        
        // let heightOneHour = self.frame.size.height/CGFloat(24*60/k_MINUTES_PER_LABEL)
        
        for var hour = 0; hour < 24; hour++ {
            
            for var min = 0; min < 60; min += k_MINUTES_PER_LABEL {
                
                let labelHourMin = FFHourAndMinLabelWithLine(date: NSDate.dateWithHour(hour, min: min))
                labelHourMin.setTranslatesAutoresizingMaskIntoConstraints(false)
                labelHourMin.textColor = min == 0 ? UIColor.grayColor() : UIColor.clearColor()
                self.addSubview(labelHourMin)
                
                arrayLabelsHourAndMin.append(labelHourMin)
            }
        }
        
        self.addConstraints(NSLayoutConstraint.constraintsAlongAxisWithViews(arrayLabelsHourAndMin, horizontalOrVerticalAxis: "V", verticalMargin: 0, horizontalMargin: 5, innerMargin: 0))
        
        labelRed = FFHourAndMinLabelWithLine(date: NSDate())
        labelRed.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelRed.textColor = UIColor.redColor()
        labelRed.alpha = 0
        self.addSubview(labelRed)
        
        reloadLabelRed()
    }
    
    private func reloadLabelRed() {
        
        if let date = date {
            
            labelBottomLabelRed?.alpha = 1
            let compNow = NSDate.componentsOfCurrentDate()
            let boolIsToday = NSDate.isTheSameDateTheCompA(compNow, andCompB:date.components())
            
            if boolIsToday {
                
                for label in arrayLabelsHourAndMin {
                    
                    let compLabel = label.dateHourAndMin.components()
                    if compLabel.hour == compNow.hour && compLabel.minute <= compNow.minute && compNow.minute < compLabel.minute+k_MINUTES_PER_LABEL {
                        
                        labelBottomLabelRed = label
                        
                        labelRed.dateHourAndMin = NSDate()
                        labelRed.showText()
                        
                        if let arrayConstraintsLabelRed = arrayConstraintsLabelRed {
                            self.removeConstraints(arrayConstraintsLabelRed)
                        }
                        arrayConstraintsLabelRed = []
                        
                        arrayConstraintsLabelRed?.append(NSLayoutConstraint(item: labelRed, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
                        arrayConstraintsLabelRed?.append(NSLayoutConstraint(item: labelRed, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
                        arrayConstraintsLabelRed?.append(NSLayoutConstraint(item: labelRed, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
                        arrayConstraintsLabelRed?.append(NSLayoutConstraint(item: labelRed, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
                        
                        self.addConstraints(arrayConstraintsLabelRed!)
                        
                        break
                    }
                }
                
                self.layoutIfNeeded()
            }
            
            labelRed.alpha = CGFloat(boolIsToday)
            labelBottomLabelRed?.alpha = CGFloat(!boolIsToday)
        }
    }
    
    // MARK: - Show events
    
    func showEventsOfArray(arrayEvents: Array<FFEvent>?) {
        
        for subview in self.subviews {
            
            if let subview = subview as? FFBlueButton  {
                
                subview.removeFromSuperview()
            }
        }
        
        arrayButtonsEvents.removeAll()
        reloadLabelRed()
        
        if let arrayEvents = arrayEvents {
            
            let arrayFrames = []
            let dictButtonsWithSameFrame = [:]
            
            for event in arrayEvents {
                
                let button = FFBlueButton()
                button.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
                button.setTitle(event.stringCustomerName, forState: UIControlState.Normal)
                button.event = event
                self.addSubview(button)
                
                arrayButtonsEvents.append(button)
                
                var labelBegin: UILabel = UILabel()
                var labelEnd: UILabel = UILabel()
                
                for label in arrayLabelsHourAndMin {
                    
                    let compLabel = label.dateHourAndMin.components()
                    let compEventBegin = event.dateTimeBegin.components()
                    let compEventEnd = event.dateTimeEnd.components()
                    
                    if compLabel.hour == compEventBegin.hour && compLabel.minute <= compEventBegin.minute && compEventBegin.minute < compLabel.minute+k_MINUTES_PER_LABEL {
                        labelBegin = label
                    }
                    
                    if compLabel.hour == compEventEnd.hour && compLabel.minute <= compEventEnd.minute && compEventEnd.minute < compLabel.minute+k_MINUTES_PER_LABEL {
                        labelEnd = label
                    }
                }
                
                let k_button = "button"
                let dictViews = [k_button: button]
                
                self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format: "H:|-70-[%@]-70-|"), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
                self.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: labelBegin, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: labelEnd, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
                
                // Save Frames for next step
                
                
                //            NSValue *value = [NSValue valueWithCGRect:_button.frame];
                //            if ([arrayFrames containsObject:value]) {
                //                NSMutableArray *array = [dictButtonsWithSameFrame objectForKey:value];
                //                if (!array){
                //                    array = [[NSMutableArray alloc] initWithObjects:[arrayButtonsEvents objectAtIndex:[arrayFrames indexOfObject:value]], nil];
                //
                //                }
                //                [array addObject:_button];
                //                [dictButtonsWithSameFrame setObject:array forKey:value];
                //            }
                //            [arrayFrames addObject:value];
            }
            
            self.layoutIfNeeded()
            
            //        // Recaulate frames of buttons that have the same begin and end date
            //        for (NSValue *value in dictButtonsWithSameFrame) {
            //            NSArray *array = [dictButtonsWithSameFrame objectForKey:value];
            //            CGFloat width = (self.frame.size.width-95.)/array.count;
            //            for (int i = 0; i < array.count; i++) {
            //                UIButton *buttonInsideArray = [array objectAtIndex:i];
            //                [buttonInsideArray setFrame:CGRectMake(70+i*width, buttonInsideArray.frame.origin.y, width, buttonInsideArray.frame.size.height)];
            //            }
            //        }
            
        }
    }
    
    // MARK: - Action
    
    private func buttonAction(sender: AnyObject?) {
        
        if let button = sender as? FFBlueButton, let protocolCustom = protocolCustom {
            
            protocolCustom.cell(self, showViewDetailsWithEvent: button.event)
        }
    }
}