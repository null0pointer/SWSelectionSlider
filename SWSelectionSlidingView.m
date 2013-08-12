//
//  SWSelectionSlidingView.m
//  CashFLow
//
//  Created by Sam Watson on 8/08/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import "SWSelectionSlidingView.h"

@implementation SWSelectionSlidingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutOptions:(NSArray *)options {
    
}

- (void)present {
    self.alpha = 0.0;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 1.0;
    } completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 delay:0.0 options:0 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setOriginY:(CGFloat)yOrigin {
    CGRect frame = self.frame;
    frame.origin.y = yOrigin;
    self.frame = frame;
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    if (CGRectContainsPoint(self.bounds, point)) {
        return self.scrollView;
    }
    
    return [super hitTest: point withEvent: event];
}

@end
