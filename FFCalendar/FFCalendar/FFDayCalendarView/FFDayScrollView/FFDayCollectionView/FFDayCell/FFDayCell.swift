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

// MARK: -

class FFDayCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var protocolCustom: FFDayCellProtocol?
    var date: NSDate?
    
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
        
        var y = 0
        
        let compNow = NSDate.componentsOfCurrentDate()
        
        for var hour = 0; hour <= 23; hour++ {
            
            for var min = 0; min <= 45; min += k_MINUTES_PER_LABEL {
                
                //    FFHourAndMinLabel *labelHourMin = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, HEIGHT_CELL_MIN) date:[NSDate dateWithHour:hour min:min]];
                let labelHourMin = FFHourAndMinLabel(date: NSDate.dateWithHour(hour, min: min))
                labelHourMin.frame = CGRect(x: 0, y: CGFloat(y), width: self.frame.size.width, height: CGFloat(k_HEIGHT_CELL_MIN))
                labelHourMin.textColor = UIColor.grayColor()
                
                if min == 0 {
                    
                    labelHourMin.showText()
                    labelHourMin.sizeToFit()
                    
                    //        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(labelHourMin.frame.origin.x+width+10, HEIGHT_CELL_MIN/2., self.frame.size.width-labelHourMin.frame.origin.x-width-20, 1.)];
                    let viewLineGray = UIView()
                    viewLineGray.frame = CGRect(x: labelHourMin.frame.origin.x+labelHourMin.frame.size.width+10, y: CGFloat(k_HEIGHT_CELL_MIN/2), width: self.frame.size.width-labelHourMin.frame.origin.x-labelHourMin.frame.size.width-20, height: CGFloat(1))
                    viewLineGray.backgroundColor = UIColor.customGrayLight()
                    labelHourMin.addSubview(viewLineGray)
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

                y += k_HEIGHT_CELL_MIN
            }
        }
    }
    
    private func labelWithCurrentHourWithWidth(_width: CGFloat, _yCurrent: CGFloat) -> FFHourAndMinLabel {
        
        //    let label = [[FFHourAndMinLabel alloc] initWithFrame:CGRectMake(.0, _yCurrent, _width, HEIGHT_CELL_MIN) date:[NSDate date]];
        let label = FFHourAndMinLabel(date: NSDate())
        label.frame = CGRect(x: 0, y: _yCurrent, width: _width, height: CGFloat(k_HEIGHT_CELL_MIN))
        label.showText()
        label.textColor = UIColor.redColor()
        label.sizeToFit()
        
        //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(label.frame.origin.x+width+10., HEIGHT_CELL_MIN/2., _width-label.frame.origin.x-width-20., 1.)];
        let view = UIView()
        view.frame = CGRect(x: label.frame.origin.x+label.frame.size.width+10, y: CGFloat(k_HEIGHT_CELL_MIN/2), width: _width-label.frame.origin.x-label.frame.size.width-20, height: 1)
        view.backgroundColor = UIColor.redColor()
        label.addSubview(view)
        
        return label
    }
    
    // MARK: -- Add Event Buttons
    
    private func addButtonsOfArray(arrayEvents: Array<FFEvent>?) {
        
        for subview in self.subviews {
            if let subviewUnw = subview as? FFBlueButton  {
                subviewUnw.removeFromSuperview()
            }
        }
        
        arrayButtonsEvents?.removeAll()
        reloadLabelRed()
        
        if let arrayEventsUnw = arrayEvents {
            
            let arrayFrames = []
            let dictButtonsWithSameFrame = [:]
            
            for event in arrayEventsUnw {
                
                var yTimeBegin: CGFloat = 0
                var yTimeEnd: CGFloat = 0
                
                if let arrayLabelsHourAndMinUnw = arrayLabelsHourAndMin {
                    
                    for label in arrayLabelsHourAndMinUnw {
                        
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
                    
                    //  FFBlueButton *_button = [[FFBlueButton alloc] initWithFrame:CGRectMake(70., yTimeBegin, self.frame.size.width-95., yTimeEnd-yTimeBegin)];
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
        
        if let dateUnw = date {
            
            if let arrayLabelsHourAndMinUnw = arrayLabelsHourAndMin {
                
                labelWithSameYOfCurrentHour?.alpha = 1
                let compNow = NSDate.componentsOfCurrentDate()
                let boolIsToday = NSDate.isTheSameDateTheCompA(compNow, andCompB:dateUnw.components())
                
                if boolIsToday {
                    
                    for label in arrayLabelsHourAndMinUnw {
                        
                        let compLabel = label.dateHourAndMin.components()
                        if compLabel.hour == compNow.hour && compLabel.minute <= compNow.minute && compNow.minute < compLabel.minute+k_MINUTES_PER_LABEL {
                            
                            if let frameUnw = labelRed?.frame {
                                
                                //    CGRect frame = labelRed.frame;
                                //    frame.origin.y = label.frame.origin.y;
                                //    [labelRed setFrame:frame];
                                labelRed?.frame = CGRectMake(frameUnw.origin.x, label.frame.origin.y, frameUnw.size.width, frameUnw.size.height)
                                labelRed?.dateHourAndMin = NSDate()
                                labelRed?.showText
                                
                                labelWithSameYOfCurrentHour = label
                                break
                            }
                        }
                    }
                }
                
                labelRed?.alpha = CGFloat(boolIsToday)
                labelWithSameYOfCurrentHour?.alpha = CGFloat(!boolIsToday)
            }
        }
    }
    
    // MARK: -- Action
    
    private func buttonAction(sender: AnyObject?) {
        
        if let button = sender as? FFBlueButton, let protocolCustom = protocolCustom {
                
                protocolCustom.cell(self, showViewDetailsWithEvent: button.event)
        }
    }
}