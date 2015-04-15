//
//  FFDayHeaderCollectionView.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

protocol FFDayHeaderCollectionViewProtocol {
    
    func dateSelected(date: NSDate)
}

class FFDayHeaderCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FFDayHeaderCellDelegate {
    
    // MARK: - Properties 
    
    var protocolCustom: FFDayHeaderCollectionViewProtocol?
    
    private var lastContentOffset: CGFloat?
    private var boolGoPrevious: Bool = false
    private var boolGoNext: Bool = false
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        
        self.registerClass(FFDayHeaderCell.classForCoder(), forCellWithReuseIdentifier: k_CELL)
        
        self.backgroundColor = UIColor.customGrayLighter()
        self.scrollEnabled = true
        self.pagingEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Scroll to Date
    
    func scrollToDate(date: NSDate) {
        
        let componentsDate = date.components()
        let compCalendar = FFDateManager.sharedManager.dateCalendar.components()
        let dateFirstDayOfMonth = NSDate.dateWithYear(compCalendar.year, month: compCalendar.month, day: 1)
        let componentsFirstDayOfMonth = dateFirstDayOfMonth?.components()
        
        var x: Int = 0
        
        if let componentsFirstDayOfMonth = componentsFirstDayOfMonth {
            
            for var i=1-(componentsFirstDayOfMonth.weekday-1), j = 7*FFDateManager.sharedManager.dateCalendar.numberOfWeekInMonthCount()-(componentsFirstDayOfMonth.weekday-1); i<=j; i++ {
                
                let dateFor = NSDate.dateWithYear(compCalendar.year, month: compCalendar.month, day: i)
                
                if let compFor = dateFor?.components() {
                    if NSDate.isTheSameDateTheCompA(componentsDate, andCompB: compFor) {
                        break
                    }
                }
                
                x++
            }
            
            self.scrollToItemAtIndexPath(NSIndexPath(forItem: x+(7-compCalendar.weekday)+7, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Right, animated: false)
        }
    }
    
    // MARK: - UIScrollView Methods
    
    override func touchesShouldCancelInContentView(view: UIView!) -> Bool {
        
        return true
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(k_CELL, forIndexPath: indexPath) as! FFDayHeaderCell
        cell.protocolCustom = self
        
        let compCalendar = FFDateManager.sharedManager.dateCalendar.components()
        
        let dateFirstDayOfMonth = NSDate.dateWithYear(compCalendar.year, month: compCalendar.month, day: 1)
        let compFirstDayOfMonth = dateFirstDayOfMonth?.components()
        
        if let compFirstDayOfMonth = compFirstDayOfMonth {
            
            cell.date = NSDate.dateWithYear(compCalendar.year, month: compCalendar.month, day: 1+indexPath.row-(compFirstDayOfMonth.weekday-1)-7)
            
            if cell.selected, let dateCell = cell.date {
                protocolCustom?.dateSelected(dateCell)
            }
        }
        
        return cell;
    }
        
    // MARK: - UICollectionView Delegate FlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (self.frame.size.width-CGFloat(k_SPACE_COLLECTIONVIEW_CELL*(k_QNT_BY_PAGING-1)))/CGFloat(k_QNT_BY_PAGING), height: self.frame.size.height)
    }
    
    // MARK: - UIScrollView Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if !boolGoPrevious && scrollView.contentOffset.x < 0 {
            boolGoPrevious = true
        }
        
        if !boolGoNext && scrollView.contentOffset.x > CGFloat(FFDateManager.sharedManager.dateCalendar.numberOfWeekInMonthCount()-1)*scrollView.frame.size.width {
            boolGoNext = true
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        lastContentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let compCalendar = FFDateManager.sharedManager.dateCalendar.components()
        let scrollDirection: ScrollDirection

        if lastContentOffset > scrollView.contentOffset.x || boolGoPrevious {
            scrollDirection = ScrollDirection.Right
            compCalendar.day -= k_QNT_BY_PAGING
            
        } else if lastContentOffset < scrollView.contentOffset.x || boolGoNext {
            scrollDirection = ScrollDirection.Left
            compCalendar.day += k_QNT_BY_PAGING
            
        } else {
            scrollDirection = ScrollDirection.None
        }
        
        protocolCustom?.dateSelected(FFDateManager.sharedManager.dateCalendar)
        
        let date = NSCalendar.currentCalendar().dateFromComponents(compCalendar)
        FFDateManager.sharedManager.dateCalendar = date
        
        boolGoPrevious = false
        boolGoNext = false
    }
    
    // MARK: - FFDayHeaderCell Delegate
    
    func cell(cell: UICollectionViewCell, dateSelected date: NSDate) {
        
        protocolCustom?.dateSelected(date)
        self.reloadData()
    }
}
