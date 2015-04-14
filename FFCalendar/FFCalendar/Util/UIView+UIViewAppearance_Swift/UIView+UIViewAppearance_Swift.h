//
//  UIView+UIViewAppearance_Swift.h
//  FFCalendar
//
//  Created by Hive on 4/14/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewAppearance_Swift)

+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;

@end
