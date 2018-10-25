//
//  NetworkManager.m
//  F1Countdoun
//
//  Created by Alok Karnik on 20/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager
- (void) makeGetRequestForUrlString:(NSString *)url completionHandler:(void (^)(NSDictionary *dict))completionHandler {
    NSURL *apiURL = [NSURL URLWithString:url];
    NSURLSession *getSession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *getScheduleTask = [getSession dataTaskWithURL:apiURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler([NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    [getScheduleTask resume];
}
@end
