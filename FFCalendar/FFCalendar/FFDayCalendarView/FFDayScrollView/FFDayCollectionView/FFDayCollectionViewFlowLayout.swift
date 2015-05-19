//
//  FFDayCollectionViewFlowLayout.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

class FFDayCollectionViewFlowLayout: FFDayHeaderCollectionViewFlowLayout {
    
    // MARK: - Lifecycle
    
    override init() {
        
        super.init()
        
        self.spaceBetweenCells = 0
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        var size = CGSizeZero
        
        if let collectionView = self.collectionView {
            
            size = CGSize(width: CGFloat(7*(FFDateManager.sharedManager.dateCalendar.numberOfWeekInMonthCount()+2))*collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
        
        return size
    }

}
