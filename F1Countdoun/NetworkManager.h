//
//  NetworkManager.h
//  F1Countdoun
//
//  Created by Alok Karnik on 20/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
- (void) makeGetRequestForUrlString:(NSString *)url completionHandler:(void (^)(NSDictionary *dict))completionHandler;
@end
