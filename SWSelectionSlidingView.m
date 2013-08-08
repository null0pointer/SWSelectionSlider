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
    [UIView animateWithDuration:0.25 delay:0.0 options:nil animations:^{
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate slidingView:self touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate slidingView:self touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate slidingView:self touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate slidingView:self touchesCancelled:touches withEvent:event];
}

@end
