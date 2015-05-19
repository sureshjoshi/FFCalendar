//
//  FFCalendarViewController.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

protocol FFCalendarViewControllerProtocol {
    
    func arrayUpdatedWithAllEvents(arrayUpdated: Array<FFEvent>)
}

class FFCalendarViewController: UIViewController, FFDayCalendarViewProtocol {
    
    // MARK: - Properties
    
    var protocolCustom: FFCalendarViewControllerProtocol?
    var dictEvents: Dictionary<NSDate, Array<FFEvent>>?
    var arrayWithEvents: Array<FFEvent>? {
        
        didSet {
            
            dictEvents = [:]
            
            if let arrayWithEvents = arrayWithEvents {
                
                for event in arrayWithEvents {
                    
                    let comp = event.dateDay.components()
                    let newDate = NSDate.dateWithYear(comp.year, month: comp.month, day: comp.day)
                    
                    var array:[FFEvent]? = dictEvents?[newDate!]
                    
                    if let arrayC = array {
                        
                        array?.append(event)
                        dictEvents?[newDate!] = array
                    
                    } else {
                        array = [event]
                        dictEvents?[newDate!] = array
                    }
                }
            }
        }
    }
    
    private var calendarDayView: FFDayCalendarView!
    private var boolDidLoad: Bool! = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addSubviews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("dateChanged:"), name: k_DATE_MANAGER_DATE_CHANGED, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if boolDidLoad == false {
            
            boolDidLoad = true
            buttonTodayAction(nil)
        }
    }
    
    // MARK: - Rotation

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        self.calendarDayView.invalidateLayout()
        
        coordinator.animateAlongsideTransition(nil, completion: {context in
           
            self.calendarDayView.dateChanged(nil)
        })
    }
    
    // MARK: - FFDateManager Notification
    
    func dateChanged(not: NSNotification?) {
        
    }

    
    // MARK: - Action
    
    private func buttonTodayAction(sender: AnyObject?) {
        
        let comp = NSDate.componentsOfCurrentDate()
        let date = NSDate.dateWithYear(comp.year, month: comp.month, day: comp.day)
        
        FFDateManager.sharedManager.dateCalendar = date
    }
    
    // MARK: - FFDayCalendarView Protocol
    
    func updateCalendarWithNewDictionary(dict: Dictionary<NSDate, Array<FFEvent>>) {
        
        dictEvents = dict
        
        calendarDayView.dictEvents = dictEvents
    }
    
    // MARK: - Sending Updated Array to FFCalendarViewController Protocol
    
    func arrayUpdatedWithAllEvents() {
        
        var arrayNew: Array<FFEvent> = []
        
        if let let arrayKeys = dictEvents?.keys {
            for date in arrayKeys {
                if let arrayOfDate = dictEvents?[date] {
                    for event in arrayOfDate {
                        arrayNew.append(event)
                    }
                }
            }
            protocolCustom?.arrayUpdatedWithAllEvents(arrayNew)
        }
    }
    
    // MARK: - Add subviews 
    
    private func addSubviews() {
        
        calendarDayView = FFDayCalendarView()
        calendarDayView.setTranslatesAutoresizingMaskIntoConstraints(false)
        calendarDayView.protocolCustom = self
        calendarDayView.dictEvents = dictEvents
        self.view.addSubview(calendarDayView)
        
        let k_CALENDAR_DAY = "calendarDay"
        let dictViews = [k_CALENDAR_DAY: calendarDayView]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]-0-|", k_CALENDAR_DAY), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"V:|-0-[%@]-0-|", k_CALENDAR_DAY), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        
        self.view.layoutIfNeeded()

    }
}
