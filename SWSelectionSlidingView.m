//
//  SWSelectionSlidingView.m
//  CashFLow
//
//  Created by Sam Watson on 8/08/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import "SWSelectionSlidingView.h"

@implementation SWSelectionSlidingView

- (void)layoutOptions:(NSArray *)options {
    CGRect labelFrame;
    labelFrame.origin.x = 0;
    labelFrame.size.width = self.frame.size.width;
    labelFrame.size.height = self.frame.size.height / options.count;
    
    for (int i = 0; i < options.count; i++) {
        labelFrame.origin.y = i * labelFrame.size.height;
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.text = [options objectAtIndex:i];
        [self addSubview:label];
    }
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
