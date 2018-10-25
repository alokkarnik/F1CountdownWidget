//
//  TyreView.h
//  F1Countdoun
//
//  Created by Alok Karnik on 18/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TyreView : UIView

- (void) updateTyreColor:(UIColor *)tyreColor;
- (void) updateStrokeEnd:(float) strokeEnd;
- (void) updateLabel:(NSInteger)time;
- (void) updateMaximumValue:(NSInteger)maxValue;
@end
