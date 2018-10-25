//
//  TyreView.m
//  F1Countdoun
//
//  Created by Alok Karnik on 18/08/18.
//  Copyright © 2018 Alok Karnik. All rights reserved.
//

#import "TyreView.h"

@interface TyreView ()
@property (nonatomic, strong) CAShapeLayer *tyreShape;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, assign) NSInteger maxValue;

@end

@implementation TyreView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tyreShape.frame = self.bounds;
    self.tyreShape.path = [[self circlePath] CGPath];
    self.tyreShape.fillRule = kCAFillRuleEvenOdd;
    //self.tyreShape.borderWidth = 15.0f;
    self.backgroundColor = [UIColor clearColor];
    self.tyreShape.borderColor = [[UIColor clearColor] CGColor];
//    [self updateProgress:self.percent];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tyreShape = [CAShapeLayer new];
    [self setupView];
    [self.layer addSublayer:self.tyreShape];
}

- (CGRect) circleFrame {
    float circleRadius = 35;
    CGRect circleFrame = CGRectMake(0, 0, 2 * circleRadius, 2 * circleRadius);
    
    circleFrame.origin.x = CGRectGetMidX(self.tyreShape.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.tyreShape.bounds) - CGRectGetMidY(circleFrame);
    return  circleFrame;
}

- (UIBezierPath *) circlePath {
    return [UIBezierPath bezierPathWithRoundedRect:[self circleFrame] cornerRadius:INFINITY];
}

- (void) setupView {
    self.tyreShape.lineWidth = 8.0f;
    self.tyreShape.position = self.center;
    self.tyreShape.fillColor = [[UIColor clearColor] CGColor];
    self.tyreShape.strokeColor = [[UIColor blackColor] CGColor];
    self.tyreShape.strokeEnd = 1.00000;
}

- (void)updateMaximumValue:(NSInteger)maxValue {
    self.maxValue = maxValue;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",maxValue];
}

- (void) updateTyreColor:(UIColor *)tyreColor {
    self.tyreShape.strokeColor = [tyreColor CGColor];
}

- (void) updateStrokeEnd:(float)strokeEnd {
    self.tyreShape.strokeEnd = strokeEnd ? strokeEnd : 0;
}

- (void)updateLabel:(NSInteger)time {
    if([self.timeLabel.text integerValue] != time) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeLabel.text = [NSString stringWithFormat:@"%ld",time];
        });
        [self updateShape];
    }
}

- (void)updateShape {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tyreShape.strokeEnd = [self.timeLabel.text floatValue]/self.maxValue;
    });
}

@end
