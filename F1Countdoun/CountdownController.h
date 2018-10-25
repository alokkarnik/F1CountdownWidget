//
//  CountdownController.h
//  F1Countdoun
//
//  Created by Alok Karnik on 20/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol F1DataProtocol  <NSObject>
- (void) gpDataUpdated;
- (void) updateCountdown;
@end

@interface CountdownController : NSObject
@property (nonatomic, weak) id<F1DataProtocol> delegate;

+ (CountdownController *) sharedInstance;
- (NSDateComponents *) getTimeUntilNextGP;
- (NSDateComponents *) getTimeFromNextGPTillNextGP;
- (NSString *) getNextGPTitle;
@end
