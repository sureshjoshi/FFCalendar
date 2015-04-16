//
//  FFDayScrollView.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

class FFDayScrollView: UIScrollView {
    
    // MARK: - Properties
    
    private var dictEvents: Dictionary<NSDate, Array<FFEvent>>? {

        didSet {
            collectionViewDay.dictEvents = dictEvents
            collectionViewDay.reloadData()
        }
    }
    
    private var collectionViewDay: FFDayCollectionView!
//    private var labelWithActualHour: FFHourAndMinLabelWithLine!
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layoutIfNeeded()

        self.contentSize = (CGSizeMake(self.frame.size.width, collectionViewDay.frame.origin.y+collectionViewDay.frame.size.height))
    }
    
    // MARK: - Add Subviews
   
    func addSubviews() {
        
        collectionViewDay = FFDayCollectionView(frame: CGRectZero, collectionViewLayout: FFDayCollectionViewFlowLayout())
        collectionViewDay.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(collectionViewDay)
        
        let k_COLLECTIONVIEWDAY = "collectionViewDay"
        var dictViews: [String: UIView] = [k_COLLECTIONVIEWDAY: collectionViewDay]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]", k_COLLECTIONVIEWDAY), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"V:|-0-[%@]", k_COLLECTIONVIEWDAY), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
        self.addConstraint(NSLayoutConstraint(item: collectionViewDay, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: collectionViewDay, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 3, constant: 0))
        
//        labelWithActualHour = FFHourAndMinLabelWithLine(date: NSDate())
//        labelWithActualHour.setTranslatesAutoresizingMaskIntoConstraints(false)
//        labelWithActualHour.textColor = UIColor.redColor()
//        self.addSubview(labelWithActualHour)
//        
//        let k_LABEL = "label"
//        dictViews[k_LABEL] = labelWithActualHour
//        
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]", k_LABEL), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"V:|-0-[%@]", k_LABEL), options: NSLayoutFormatOptions(0), metrics: nil, views: dictViews))
//        self.addConstraint(NSLayoutConstraint(item: labelWithActualHour, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: labelWithActualHour, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        
        self.layoutIfNeeded()
        
//        collectionViewDay.scrollToItemAtIndexPath(NSIndexPath(forItem: FFDateManager.sharedManager.dateCalendar.components().day-1+7, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
//
//        [self scrollRectToVisible:CGRectMake(0, labelWithActualHour.frame.origin.y, self.frame.size.width, self.frame.size.height) animated:NO];
    }
}
