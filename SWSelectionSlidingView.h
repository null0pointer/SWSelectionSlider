//
//  SWSelectionSlidingView.h
//  CashFLow
//
//  Created by Sam Watson on 8/08/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWSelectionSlidingView;

@protocol SWSelectionSlidingViewDelegate <NSObject>

- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface SWSelectionSlidingView : UIView

@property (weak, nonatomic) id <SWSelectionSlidingViewDelegate> delegate;

- (void)layoutOptions:(NSArray *)options;

- (void)present;
- (void)dismiss;

- (void)setOriginY:(CGFloat)yOrigin;

@end
