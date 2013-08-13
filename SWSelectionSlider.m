//
//  SWSelectionSlider.m
//  
//
//  Created by Sam Watson on 3/08/13.
//
//

#import "SWSelectionSlider.h"

@implementation SWSelectionSlider {
    CGPoint originInKeyWindow;
    
    BOOL isShowingScrollView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.sliderScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.sliderScrollView.backgroundColor = [UIColor clearColor];
        [self.sliderScrollView setShowsVerticalScrollIndicator:NO];
        self.sliderScrollView.delegate = self;
        [self addSubview:self.sliderScrollView];
        
        self.selectionLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.selectionLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.selectionLabel];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleScrollViewTap:)];
        [recognizer setNumberOfTapsRequired:1];
        [recognizer setNumberOfTouchesRequired:1];
        [self.sliderScrollView addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)handleScrollViewTap:(UITapGestureRecognizer *)recognizer {
    if (isShowingScrollView) {
        
    } else {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect globalFrame = [self convertRect:self.bounds toView:keyWindow];
        originInKeyWindow = CGPointMake(globalFrame.origin.x, globalFrame.origin.y);	
        
        CGRect frame;
        frame.origin.x = originInKeyWindow.x;
        frame.size.width = self.frame.size.width;
        frame.size.height = self.frame.size.height * [self.dataSource numberOfSelectionsForSlider:self];
        frame.origin.y = originInKeyWindow.y - (self.frame.size.height * self.selectedIndex);
        
        self.sliderView = [[SWSelectionSlidingView alloc] initWithFrame:frame];
        self.sliderView.scrollView = self.sliderScrollView;
        
        self.sliderView.backgroundColor = [UIColor redColor];
        
        NSMutableArray *optionsArray = [NSMutableArray arrayWithCapacity:[self.dataSource numberOfSelectionsForSlider:self]];
        for (int i = 0; i < [self.dataSource numberOfSelectionsForSlider:self]; i++) {
            [optionsArray addObject:[self.dataSource slider:self titleForSelectionAtIndex:i]];
        }
        [self.sliderView layoutOptions:optionsArray];
        
        self.sliderScrollView.contentSize = self.sliderView.frame.size;
        self.sliderScrollView.contentOffset = CGPointMake(0, self.frame.size.height * self.selectedIndex);
        
        [self.sliderView present];
        
        isShowingScrollView = YES;
    }
}

- (void)dismissSliderView {
    [self.sliderView dismiss];
    isShowingScrollView = NO;
}

- (CGFloat)roundContentOffset:(CGFloat)offset {
    offset = offset / self.frame.size.height;
    offset = roundf(offset);
    offset = offset * self.frame.size.height;
    return offset;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!isShowingScrollView) {
        [self handleScrollViewTap:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.sliderDismissalTimer) {
        [self.sliderDismissalTimer invalidate];
        self.sliderDismissalTimer = nil;
    }
    
    [self.sliderView setOriginY:(originInKeyWindow.y - scrollView.contentOffset.y)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat newOffset = [self roundContentOffset:offset];
    
    if (offset != newOffset) {
        [self.sliderScrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, newOffset) animated:YES];
    }
    
    self.sliderDismissalTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissSliderView) userInfo:nil repeats:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.sliderDismissalTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dismissSliderView) userInfo:nil repeats:NO];
}

@end
