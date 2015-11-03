//
//  FFOrangeAndWhiteButton.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/23/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFOrangeAndWhiteButton.h"

#import "FFImportantFilesForCalendar.h"

#import "UIColor+BPColors.h"

@implementation FFOrangeAndWhiteButton

- (id)initWithFrame:(CGRect)frame
{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        // Initialization code
        
        [self setFrame:frame];
        
        [self setTitleColor:[UIColor bp_dustyOrangeColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor bp_dustyOrangeColor]] forState:UIControlStateSelected];
        
        [self.layer setBorderColor:[UIColor bp_dustyOrangeColor].CGColor];
        [self.layer setBorderWidth:1.];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSelected:(BOOL)_selected {

    self.selected = _selected;
    
    if(_selected) {
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    } else {
        [self.layer setBorderColor:[UIColor bp_dustyOrangeColor].CGColor];
    }
}

@end
