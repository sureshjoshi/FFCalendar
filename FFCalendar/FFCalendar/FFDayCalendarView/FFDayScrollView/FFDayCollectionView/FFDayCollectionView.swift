//
//  FFDayCollectionView.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

protocol FFDayCollectionViewProtocol {
    
    func collectionView(collectionView: UICollectionView, updateHeaderWithDate date: NSDate)
    func collectionView(collectionView: UICollectionView, showViewDetailsWithEvent event: FFEvent?)
}

class FFDayCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FFDayCellProtocol {
    
    // MARK: - Properties
    
    var protocolCustom: FFDayCollectionViewProtocol?
    var dictEvents: Dictionary<NSDate, Array<FFEvent>>?
    
    private let quantityByPaging: Int! = 1
    private var lastContentOffset: CGFloat! = 0
    private var boolGoPrevious: Bool! = false
    private var boolGoNext: Bool! = false
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        
        self.registerClass(FFDayCell.classForCoder(), forCellWithReuseIdentifier: k_CELL)
        
        self.backgroundColor = UIColor.yellowColor()
        self.scrollEnabled = true
        self.pagingEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UICollectionView DataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let intDay = 7 * (FFDateManager.sharedManager.dateCalendar.numberOfWeekInMonthCount() + 2)
        
        return intDay
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let comp = FFDateManager.sharedManager.dateCalendar.components()
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(k_CELL, forIndexPath: indexPath) as! FFDayCell
        cell.protocolCustom = self
        cell.date = NSDate.dateWithYear(comp.year, month: comp.month, day: 1+indexPath.row-7)
        
        if let dictEvents = dictEvents, date = cell.date {
            cell.showEventsOfArray(dictEvents[date])
        }
        
        return cell
    }
    
    // MARK: - UICollectionView Delegate FlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var size = CGSizeZero
        
        if let collectionViewLayout = collectionViewLayout as? FFDayHeaderCollectionViewFlowLayout {
            
            size = CGSize(width: (self.frame.size.width-collectionViewLayout.spaceBetweenCells*(CGFloat(quantityByPaging-1)))/CGFloat(quantityByPaging), height: self.frame.size.height)
        }
        
        return size
    }
    
    
    // MARK: - UIScrollView Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if !boolGoPrevious && scrollView.contentOffset.x < 0 {
            boolGoPrevious = true
        }
        
        if !boolGoNext && scrollView.contentOffset.x > 7*CGFloat(FFDateManager.sharedManager.dateCalendar.numberOfWeekInMonthCount()+2-1)*scrollView.frame.size.width {
            boolGoNext = true
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        lastContentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let compCalendar = FFDateManager.sharedManager.dateCalendar.components()
        let scrollDirection: ScrollDirection
        
        if lastContentOffset > scrollView.contentOffset.x || boolGoPrevious == true {
            scrollDirection = ScrollDirection.Right
            compCalendar.day -= quantityByPaging
            
        } else if lastContentOffset < scrollView.contentOffset.x || boolGoNext == true {
            scrollDirection = ScrollDirection.Left
            compCalendar.day += quantityByPaging
            
        } else {
            scrollDirection = ScrollDirection.None
        }
        
        if let date = NSDate.dateWithYear(compCalendar.year, month: compCalendar.month, day: compCalendar.year) {
            
            protocolCustom?.collectionView(self, updateHeaderWithDate: date)
        }
        
        boolGoPrevious = false
        boolGoNext = false
    }
    
    // MARK: - FFDayCell Protocol
    
    func cell(cell: UICollectionViewCell, showViewDetailsWithEvent event: FFEvent?) {
        
        protocolCustom?.collectionView(self, showViewDetailsWithEvent: event)
    }
}
