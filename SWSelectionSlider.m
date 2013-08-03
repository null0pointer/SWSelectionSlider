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
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.sliderView = [[UIView alloc] init];
    self.sliderView.backgroundColor = [UIColor redColor];
    
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
    
    CGRect frame = self.sliderView.frame;
    frame.origin.y = globalPoint.y - originalTouchPoint.y - (self.frame.size.height * self.selectedIndex);
    self.sliderView.frame = frame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.sliderView removeFromSuperview];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
