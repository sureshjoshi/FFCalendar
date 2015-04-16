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
    
    private var arrayLabelsHourAndMin: Array<FFHourAndMinLabel>? = []
    private var arrayButtonsEvents: Array<FFBlueButton>? = []
    private var button: FFBlueButton?
    private var yCurrent: Float?
    private var labelWithSameYOfCurrentHour: UILabel?
    private var labelRed: FFHourAndMinLabel?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addLines()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public Methods
    
    func showEventsOfArray(array: Array<FFEvent>?) {
        
        addButtonsOfArray(array)
    }
    
    // MARK: - Private Methods
    
    // MARK: -- Add Lines
    
    private func addLines() {
        
        var y:CGFloat = 0
        
        let compNow = NSDate.componentsOfCurrentDate()
        
        let heightOneHour = self.frame.size.height/CGFloat(24*60/k_MINUTES_PER_LABEL)
        
        for var hour = 0; hour < 24; hour++ {
            
            for var min = 0; min < 60; min += k_MINUTES_PER_LABEL {
                
                let labelHourMin = FFHourAndMinLabelWithLine(date: NSDate.dateWithHour(hour, min: min))
                labelHourMin.frame = CGRect(x: 5, y: CGFloat(y), width: self.frame.size.width-10, height: CGFloat(heightOneHour))
                labelHourMin.textColor = UIColor.clearColor()
                
                if min == 0 {
                    
                    labelHourMin.textColor = UIColor.grayColor()
                }
                
                self.addSubview(labelHourMin)
                
                arrayLabelsHourAndMin?.append(labelHourMin)
                
                let compLabel = NSDate.componentsWithHour(hour, min: min)
                if compLabel.hour == compNow.hour && min <= compNow.minute && compNow.minute < min+k_MINUTES_PER_LABEL {
                    
                    labelRed = labelWithCurrentHourWithWidth(labelHourMin.frame.size.width, _yCurrent: labelHourMin.frame.origin.y)
                    labelRed?.alpha = 0
                    self.addSubview(labelRed!)
                    
                    labelWithSameYOfCurrentHour = labelHourMin
                }
                
                y += heightOneHour
            }
        }
    }
    
    private func labelWithCurrentHourWithWidth(_width: CGFloat, _yCurrent: CGFloat) -> FFHourAndMinLabel {
        
        let heightOneHour = self.frame.size.height/CGFloat(24*60/k_MINUTES_PER_LABEL)
        
        let label = FFHourAndMinLabelWithLine(date: NSDate())
        label.frame = CGRect(x: 5, y: _yCurrent, width: _width-10, height: CGFloat(heightOneHour))
        label.textColor = UIColor.redColor()
        
        return label
    }
    
    // MARK: -- Add Event Buttons
    
    private func addButtonsOfArray(arrayEvents: Array<FFEvent>?) {
        
        for subview in self.subviews {
            
            if let subview = subview as? FFBlueButton  {
                
                subview.removeFromSuperview()
            }
        }
        
        arrayButtonsEvents?.removeAll()
        reloadLabelRed()
        
        if let arrayEvents = arrayEvents {
            
            let arrayFrames = []
            let dictButtonsWithSameFrame = [:]
            
            for event in arrayEvents {
                
                var yTimeBegin: CGFloat = 0
                var yTimeEnd: CGFloat = 0
                
                if let arrayLabelsHourAndMin = arrayLabelsHourAndMin {
                    
                    for label in arrayLabelsHourAndMin {
                        
                        let compLabel = label.dateHourAndMin.components()
                        let compEventBegin = event.dateTimeBegin.components()
                        let compEventEnd = event.dateTimeEnd.components()
                        
                        if compLabel.hour == compEventBegin.hour && compLabel.minute <= compEventBegin.minute && compEventBegin.minute < compLabel.minute+k_MINUTES_PER_LABEL {
                            yTimeBegin = label.frame.origin.y+label.frame.size.height/2
                        }
                        
                        if compLabel.hour == compEventEnd.hour && compLabel.minute <= compEventEnd.minute && compEventEnd.minute < compLabel.minute+k_MINUTES_PER_LABEL {
                            yTimeEnd = label.frame.origin.y+label.frame.size.height
                        }
                    }
                    
                    let _button = FFBlueButton()
                    _button.frame = CGRect(x: 70, y: yTimeBegin, width: self.frame.size.width-95, height: yTimeEnd-yTimeBegin)
                    _button.addTarget(self, action: Selector("buttonAction"), forControlEvents: UIControlEvents.TouchUpInside)
                    _button.setTitle(event.stringCustomerName, forState: UIControlState.Normal)
                    _button.event = event
                    
                    arrayButtonsEvents?.append(_button)
                    self.addSubview(_button)
                    
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
                
            }
            
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
    
    private func reloadLabelRed() {
        
        if let date = date, let arrayLabelsHourAndMin = arrayLabelsHourAndMin {
            
            labelWithSameYOfCurrentHour?.alpha = 1
            let compNow = NSDate.componentsOfCurrentDate()
            let boolIsToday = NSDate.isTheSameDateTheCompA(compNow, andCompB:date.components())
            
//            if boolIsToday {
            
                for label in arrayLabelsHourAndMin {
                    
                    let compLabel = label.dateHourAndMin.components()
                    if compLabel.hour == compNow.hour && compLabel.minute <= compNow.minute && compNow.minute < compLabel.minute+k_MINUTES_PER_LABEL {
                        
                        if let frame = labelRed?.frame {
                            
                            labelRed?.frame = label.frame
                            labelRed?.dateHourAndMin = NSDate()
                            labelRed?.showText
                            
                            labelWithSameYOfCurrentHour = label
                            
                            break
                        }
                    }
                }
//            }
            
            labelRed?.alpha = 1
            
//            labelRed?.alpha = CGFloat(boolIsToday)
//            labelWithSameYOfCurrentHour?.alpha = CGFloat(!boolIsToday)
        }
    }
    
    // MARK: -- Action
    
    private func buttonAction(sender: AnyObject?) {
        
        if let button = sender as? FFBlueButton, let protocolCustom = protocolCustom {
            
            protocolCustom.cell(self, showViewDetailsWithEvent: button.event)
        }
    }
}