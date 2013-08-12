//
//  SWSelectionSlidingView.h
//  CashFLow
//
//  Created by Sam Watson on 8/08/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWSelectionSlidingView;

@interface SWSelectionSlidingView : UIView

@property (weak, nonatomic) UIScrollView                        *scrollView;

- (void)layoutOptions:(NSArray *)options;

- (void)present;
- (void)dismiss;

- (void)setOriginY:(CGFloat)yOrigin;

@end
