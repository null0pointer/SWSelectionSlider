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
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectionLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:self.selectionLabel];
        
        self.sliderScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.sliderScrollView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = [UIColor redColor];
    
    self.sliderScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * [self.dataSource numberOfSelectionsForSlider:self]);
    self.sliderScrollView.contentOffset = CGPointMake(0, self.frame.size.height * self.selectedIndex);
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    originalTouchPoint = [[touches anyObject] locationInView:self];
    CGPoint globalPoint = [[touches anyObject] locationInView:keyWindow];
    
    CGRect frame;
    frame.origin.x = globalPoint.x - originalTouchPoint.x;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height * [self.dataSource numberOfSelectionsForSlider:self];
    frame.origin.y = globalPoint.y - originalTouchPoint.y - (self.frame.size.height * self.selectedIndex);
    self.sliderView.frame = frame;
    
    [keyWindow addSubview:self.sliderView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint globalPoint = [[touches anyObject] locationInView:keyWindow];
    CGPoint localPoint = [[touches anyObject] locationInView:self];
    CGPoint originInKeyWindow = CGPointMake(globalPoint.x - localPoint.x, globalPoint.y - localPoint.y);
    
    CGRect frame = self.sliderView.frame;
    frame.origin.y = globalPoint.y - originalTouchPoint.y - (self.frame.size.height * self.selectedIndex);
    
    if (frame.origin.y > originInKeyWindow.y) {
        frame.origin.y = originInKeyWindow.y;
    } else if (frame.origin.y < ((originInKeyWindow.y + self.frame.size.height) - self.sliderView.frame.size.height)) {
        frame.origin.y = ((originInKeyWindow.y + self.frame.size.height) - self.sliderView.frame.size.height);
    }
    
    self.sliderView.frame = frame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.sliderView removeFromSuperview];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
