//
//  TodayViewController.m
//  F1CountdownWidget
//
//  Created by Alok Karnik on 18/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import "TodayViewController.h"
#import "TyreView.h"
#import "CountdownParser.h"

#import <NotificationCenter/NotificationCenter.h>

#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float) ((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float) ((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float) (rgbValue & 0x0000FF))/255.0 \
alpha:1.0]



@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *gpTitleLabel;
@property (weak, nonatomic) IBOutlet UIStackView *tyreStackView;

@property (nonatomic, strong) IBOutlet TyreView *daysTyreView;
@property (nonatomic, strong) IBOutlet TyreView *hoursTyreView;
@property (nonatomic, strong) IBOutlet TyreView *minuteTyreView;
@property (nonatomic, strong) IBOutlet TyreView *secondsTyreView;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [CountdownController sharedInstance].delegate = self;
    [self setupUI];
}

- (void) configureTyres {
    [self.daysTyreView updateTyreColor:UIColorFromRGB(0xC65BB1)];
    [self.daysTyreView updateMaximumValue:20];
    
    [self.hoursTyreView updateTyreColor:UIColorFromRGB(0xFC403A)];
    [self.hoursTyreView updateMaximumValue:24];
    
    [self.minuteTyreView updateTyreColor:UIColorFromRGB(0xE6CE00)];
    [self.minuteTyreView updateMaximumValue:60];
    
    [self.secondsTyreView updateTyreColor:UIColorFromRGB(0x52D749)];
    [self.secondsTyreView updateMaximumValue:60];
}

- (void) updateUIWithDetails {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDateComponents *breakdownInfo = [[CountdownController sharedInstance] getTimeUntilNextGP];
        [self.daysTyreView updateLabel:[breakdownInfo day]];
        [self.hoursTyreView updateLabel:[breakdownInfo hour]];
        [self.minuteTyreView updateLabel:[breakdownInfo minute]];
        [self.secondsTyreView updateLabel:[breakdownInfo second]];
    });
}

- (void)gpDataUpdated {
    [self setupUI];
}

- (void) setupUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configureTyres];
        if([[CountdownController sharedInstance] getNextGPTitle]) {
            [self.gpTitleLabel setText:[[CountdownController sharedInstance] getNextGPTitle]];
            NSDateComponents *lastGPBreakdownInfo = [[CountdownController sharedInstance] getDaysFromLastGPTillNextGP];
            [self.daysTyreView updateMaximumValue:[lastGPBreakdownInfo day]];
        }
    });
}
- (void)updateCountdown {
    [self updateUIWithDetails];
}

@end
