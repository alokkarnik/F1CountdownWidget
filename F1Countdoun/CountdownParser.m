//
//  CountdownParser.m
//  F1Countdoun
//
//  Created by Alok Karnik on 20/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import "CountdownParser.h"

@implementation CountdownParser

+ (NSDateComponents *) getTimeUntilNextGPFrom:(NSDictionary *)gpDict {
    NSDate *gpDate = [self getGPDateFromDict:gpDict];
    return [self daysFrom:[NSDate date] to:gpDate];
}

+ (NSDateComponents *) getTimeFromLastGP:(NSDictionary *)lastRaceDict GPTill:(NSDictionary *)raceDict {
    NSDate *nextRaceDate = [self getGPDateFromDict:raceDict];
    NSDate *lastRaceDate = [self getGPDateFromDict:lastRaceDict];
    return [self daysFrom:lastRaceDate to:nextRaceDate];
}

+ (NSDate *) getGPDateFromDict:(NSDictionary *)raceDict {
    NSMutableString *gpDate = [NSMutableString stringWithString:[raceDict objectForKey:@"date"]];
    NSString *time = [NSString stringWithFormat:@" %@",[raceDict objectForKey:@"time"]];
    [gpDate appendString:time];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ssZ";
    NSDate *date = [formatter dateFromString:gpDate];
    return date;
}

+ (NSDictionary *) getActualGPFrom:(NSDictionary *) raceDict; {
    return [[[[raceDict objectForKey:@"MRData"] objectForKey:@"RaceTable"] objectForKey:@"Races"] objectAtIndex:0];
}

+ (NSDateComponents *) daysFrom:(NSDate *)fromDate to:(NSDate *)toDate {
    NSCalendarUnit unitFlags = NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ssZ";
    NSDate *currentDate = [formatter dateFromString:[NSString stringWithFormat:@"%@",fromDate]];
    
    // Next call takes care of time-zone issues. I don't know how
    NSDateComponents *breakdownInfo = [[NSCalendar currentCalendar] components:unitFlags fromDate:fromDate  toDate:toDate  options:0];
    NSLog(@"Break down: %li days : %li hours : %li mins : %li seconds from : %@ till : %@" , (long)[breakdownInfo day], (long)[breakdownInfo hour], (long)[breakdownInfo minute], (long)[breakdownInfo second], currentDate, toDate);
    
    return breakdownInfo;
}
@end
