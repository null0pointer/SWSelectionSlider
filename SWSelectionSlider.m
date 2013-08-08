//
//  SWSelectionSlider.m
//  
//
//  Created by Sam Watson on 3/08/13.
//
//

#import "SWSelectionSlider.h"

@implementation SWSelectionSlider {
    CGPoint originalTouchPoint;
    CGPoint originInKeyWindow;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        
        self.sliderScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.sliderScrollView.backgroundColor = [UIColor clearColor];
        self.sliderScrollView.delegate = self;
        [self addSubview:self.sliderScrollView];
        
        self.selectionLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.selectionLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.selectionLabel];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    originalTouchPoint = [[touches anyObject] locationInView:self];
    CGPoint globalPoint = [[touches anyObject] locationInView:keyWindow];
    originInKeyWindow = CGPointMake(globalPoint.x - originalTouchPoint.x, globalPoint.y - originalTouchPoint.y);
    
    CGRect frame;
    frame.origin.x = globalPoint.x - originalTouchPoint.x;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height * [self.dataSource numberOfSelectionsForSlider:self];
    frame.origin.y = globalPoint.y - originalTouchPoint.y - (self.frame.size.height * self.selectedIndex);
    
    self.sliderView = [[SWSelectionSlidingView alloc] initWithFrame:frame];
    self.sliderView.delegate = self;
    self.sliderView.backgroundColor = [UIColor redColor]; // DEBUG
    
    self.sliderScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * [self.dataSource numberOfSelectionsForSlider:self]);
    self.sliderScrollView.contentOffset = CGPointMake(0, self.frame.size.height * self.selectedIndex);
    
    [self.sliderView present];
    
    NSLog(@"TOUCHES BEGAN");
    [self.sliderScrollView touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGPoint globalPoint = [[touches anyObject] locationInView:keyWindow];
//    
//    CGRect frame = self.sliderView.frame;
//    frame.origin.y = globalPoint.y - originalTouchPoint.y - (self.frame.size.height * self.selectedIndex);
//    
//    if (frame.origin.y > originInKeyWindow.y) {
//        frame.origin.y = originInKeyWindow.y;
//    } else if (frame.origin.y < ((originInKeyWindow.y + self.frame.size.height) - self.sliderView.frame.size.height)) {
//        frame.origin.y = ((originInKeyWindow.y + self.frame.size.height) - self.sliderView.frame.size.height);
//    }
//    
//    self.sliderView.frame = frame;
    
    [self.sliderScrollView touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.sliderView dismiss];
    
    [self.sliderScrollView touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.sliderScrollView touchesCancelled:touches withEvent:event];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"HELLO");
    [self.sliderView setOriginY:(originInKeyWindow.y + scrollView.contentOffset.y)];
}

#pragma mark - SWSelectionSlidingViewDelegate

- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}

- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)slidingView:(SWSelectionSlidingView *)slidingView touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesCancelled:touches withEvent:event];
}

@end
