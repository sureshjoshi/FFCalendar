//
//  FFDayHeaderButton.m
//  FFCalendar
//
//  Created by Felipe Rocha on 19/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFDayHeaderButton.h"

#import "FFImportantFilesForCalendar.h"
#import "UIColor+BPColors.h"

static UIImage *imageCircleOrange;
static UIImage *imageCircleBlack;

@implementation FFDayHeaderButton

#pragma mark - Synthesize

@synthesize date;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [[UIImageView appearanceWhenContainedIn:[FFDayHeaderButton class], nil] setContentMode:UIViewContentModeScaleAspectFit];

        [self setBackgroundColor:[UIColor whiteColor]];
        [self setContentMode:UIViewContentModeCenter];

        if (!imageCircleBlack) {
            imageCircleBlack = [UIImage imageNamed:@"blueCircle"];
            imageCircleOrange = [UIImage imageNamed:@"orangeCircle"];
        }

        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    return self;
}


#pragma mark - Set Public Property

-(void)setSelected:(BOOL)selected {

    if (selected) {

        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        if ([NSDate isTheSameDateTheCompA:[NSDate componentsOfDate:date] compB:[NSDate componentsOfCurrentDate]]) {
            [self setBackgroundImage:imageCircleOrange forState:UIControlStateNormal];
        } else {
            [self setBackgroundImage:imageCircleBlack forState:UIControlStateNormal];
        }

    } else {
        if (date.componentsOfDate.weekday == 1 || date.componentsOfDate.weekday == 7) {
            [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        } else {
            [self setTitleColor:[UIColor bp_duskyBlueColor] forState:UIControlStateNormal];
        }

        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

@end
