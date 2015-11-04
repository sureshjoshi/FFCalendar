//
//  BlueButton.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFBlueButton.h"
#import "UIColor+BPColors.h"

@implementation FFBlueButton

#pragma mark - Synthesize

@synthesize event;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self setContentEdgeInsets:UIEdgeInsetsMake(5,5,5,5)];

        self.titleLabel.numberOfLines = 0;
        [self setBackgroundColor:[UIColor bp_paleGreyColor]];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [self setTitleColor:[UIColor bp_duskyBlueColor] forState:UIControlStateNormal];
        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.layer setBorderWidth:1];

        [[self layer] setCornerRadius:10];
        [self setClipsToBounds:YES];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
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

@end
