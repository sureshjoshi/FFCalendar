//
//  TestCollectionViewFlowLayout.swift
//  Jbc_iphone
//
//  Created by Hive on 2/27/15.
//  Copyright (c) 2015 Hive. All rights reserved.
//

import UIKit

class FFDayHeaderCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        var size = CGSizeZero
        
        if let collectionView = self.collectionView {
            size = CGSize(width: CGFloat((FFDateManager.sharedManager.dateCalendar.numberOfWeekInMonthCount()+2))*collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
        
        return size
    }
    
    // MARK: - Forcing de max space between cells to be equal to k_SPACE_COLLECTIONVIEW_CELL
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
        let attributesToReturn = super.layoutAttributesForElementsInRect(rect) as? [UICollectionViewLayoutAttributes]
        
        for attributes in attributesToReturn ?? [] {
            
            if attributes.representedElementKind == nil {
                attributes.frame = self.layoutAttributesForItemAtIndexPath(attributes.indexPath).frame
            }
        }
        
        return attributesToReturn
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        
        let currentItemAttributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        
        if let collectionViewFlowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let sectionInset = collectionViewFlowLayout.sectionInset
            if (indexPath.item == 0) { // first item of section
                var frame = currentItemAttributes.frame;
                frame.origin.x = sectionInset.left; // first item of the section should always be left aligned
                currentItemAttributes.frame = frame;
                
                return currentItemAttributes;
            }
            
            let previousIndexPath = NSIndexPath(forItem:indexPath.item-1, inSection:indexPath.section)
            let previousFrame = self.layoutAttributesForItemAtIndexPath(previousIndexPath).frame;
            let previousFrameRightPoint = Double(previousFrame.origin.x) + Double(previousFrame.size.width) + Double(k_SPACE_COLLECTIONVIEW_CELL)
            
            let currentFrame = currentItemAttributes.frame
            var width : CGFloat = 0.0
            if let collectionViewWidth = self.collectionView?.frame.size.width {
                width = collectionViewWidth
            }
            let strecthedCurrentFrame = CGRectMake(0,
                currentFrame.origin.y,
                width,
                currentFrame.size.height);
            
            if (!CGRectIntersectsRect(previousFrame, strecthedCurrentFrame)) { // if current item is the first item on the line
                // the approach here is to take the current frame, left align it to the edge of the view
                // then stretch it the width of the collection view, if it intersects with the previous frame then that means it
                // is on the same line, otherwise it is on it's own new line
                var frame = currentItemAttributes.frame;
                frame.origin.x = sectionInset.left; // first item on the line should always be left aligned
                currentItemAttributes.frame = frame;
                return currentItemAttributes;
            }
            
            var frame = currentItemAttributes.frame;
            frame.origin.x = CGFloat(previousFrameRightPoint)
            currentItemAttributes.frame = frame;
        }
        
        return currentItemAttributes;
    }

}