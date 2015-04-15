//
//  FFDayCalendarView.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

protocol FFDayCalendarViewDelegate {
    
    func setNewDictionary(dict: Dictionary<NSDate, Array<FFEvent>>)
}

// MARK: -

class FFDayCalendarView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    var protocolCustom: FFDayCalendarViewDelegate?
    var dictEvents: Dictionary<NSDate, Array<FFEvent>>?
    
    private var collectionViewHeaderDay: FFDayHeaderCollectionView!
    private var dayContainerScroll: FFDayScrollView!
    private var viewDetail: FFEventDetailView!
    private var viewEdit: FFEditEventView!
    
    private var boolAnimate: Bool?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
        
        self.backgroundColor = UIColor.whiteColor()
        boolAnimate = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("dateChanged:"), name: k_DATE_MANAGER_DATE_CHANGED, object: nil)
        
        let gesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        gesture.delegate = self
        self.addGestureRecognizer(gesture)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Invalidate Layout
    
    func invalidateLayout() {
        
        collectionViewHeaderDay.collectionViewLayout.invalidateLayout()
        
    }
    
    // MARK: - FFDateManager Notification
    
    func dateChanged(not: NSNotification) {
    
    }
    
    // MARK: - Add Subviews
    
    private func addSubviews() {

        collectionViewHeaderDay = FFDayHeaderCollectionView(frame: CGRectZero, collectionViewLayout: FFDayHeaderCollectionViewFlowLayout())
        collectionViewHeaderDay.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(collectionViewHeaderDay)
        
        let k_HEADER = "header"
        var dictViews:[String: UIView] = [k_HEADER: collectionViewHeaderDay]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]-0-|", k_HEADER), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"V:|-0-[%@]", k_HEADER), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.addConstraint(NSLayoutConstraint(item: collectionViewHeaderDay, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.1, constant: 0))
        
        dayContainerScroll = FFDayScrollView(frame: CGRectZero)
        dayContainerScroll.setTranslatesAutoresizingMaskIntoConstraints(false)
        dayContainerScroll.backgroundColor = UIColor.orangeColor()
        self.addSubview(dayContainerScroll)

        let k_CONTAINER = "container"
        dictViews[k_CONTAINER] = dayContainerScroll
        
        self.addConstraint(NSLayoutConstraint(item: dayContainerScroll, attribute: .Top, relatedBy: .Equal, toItem: collectionViewHeaderDay, attribute: .Bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: dayContainerScroll, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]", k_CONTAINER), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.addConstraint(NSLayoutConstraint(item: dayContainerScroll, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.5, constant: 0))
    }
}
