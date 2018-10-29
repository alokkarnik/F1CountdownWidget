//
//  CountdownController.m
//  F1Countdoun
//
//  Created by Alok Karnik on 20/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import "CountdownController.h"
#import "NetworkManager.h"
#import "CountdownParser.h"

#define NEXT_GP_API @"http://ergast.com/api/f1/current/next.json"
#define LAST_GP_API @"http://ergast.com/api/f1/current/last.json"


@interface CountdownController()
@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) NSDictionary *nextGP;
@property (nonatomic, strong) NSDictionary *lastGP;
@end

@implementation CountdownController
+ (CountdownController *) sharedInstance {
    static dispatch_once_t onceToken;
    static CountdownController *sharedInstance;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[CountdownController alloc] init];
        sharedInstance.networkManager = [[NetworkManager alloc] init];
        [sharedInstance fetchData];
        [sharedInstance startTimer];
    });

    return sharedInstance;
}

- (void)fetchData {
    [self.networkManager makeGetRequestForUrlString:NEXT_GP_API completionHandler:^(NSDictionary *dict) {
        self.nextGP = [CountdownParser getActualGPFrom:dict];
        [self.networkManager makeGetRequestForUrlString:LAST_GP_API completionHandler:^(NSDictionary *dict) {
            self.lastGP = [CountdownParser getActualGPFrom:dict];;
            if([self.delegate respondsToSelector:@selector(gpDataUpdated)]) {
                [self.delegate gpDataUpdated];
            }
        }];
    }];

}

- (void) startTimer {
    NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:countdownTimer forMode:NSRunLoopCommonModes];
}

- (void) updateUI {
    if([self.delegate respondsToSelector:@selector(updateCountdown)]) {
        [self.delegate updateCountdown];
    }
}

- (NSDateComponents *) getTimeUntilNextGP {
    NSDateComponents *timeUntilNextGP = [CountdownParser getTimeUntilNextGPFrom:self.nextGP];
    if([[NSDate date] compare:[[NSCalendar currentCalendar] dateFromComponents:timeUntilNextGP]]== NSOrderedAscending) {
        [self fetchData];
    }
    return timeUntilNextGP;
}

- (NSDateComponents *) getDaysFromLastGPTillNextGP {
    return [CountdownParser getTimeFromLastGP:self.lastGP GPTill:self.nextGP];
}

- (NSString *)getNextGPTitle {
    return [self.nextGP objectForKey:@"raceName"];
}

@end
