//
//  UIView+UIViewAppearance_Swift.m
//  FFCalendar
//
//  Created by Hive on 4/14/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

#import "UIView+UIViewAppearance_Swift.h"

@implementation UIView (UIViewAppearance_Swift)

+ (instancetype)my_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    
    return [self appearanceWhenContainedIn:containerClass, nil];
}

@end
