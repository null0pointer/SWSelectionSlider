//
//  SWSelectionSlider.h
//  
//
//  Created by Sam Watson on 3/08/13.
//
//

#import <UIKit/UIKit.h>
#import "SWSelectionSlidingView.h"

@class SWSelectionSlider;

@protocol SWSelectionSliderDataSource <NSObject>

- (NSInteger)numberOfSelectionsForSlider:(SWSelectionSlider *)slider;
- (NSString *)slider:(SWSelectionSlider *)slider titleForSelectionAtIndex:(NSInteger)index;

@end

@protocol SWSelectionSliderDelegate <NSObject>

- (void)slider:(SWSelectionSlider *)slider didSelectIndex:(NSInteger)index;

@end

@interface SWSelectionSlider : UIView <UIScrollViewDelegate, SWSelectionSlidingViewDelegate>

@property (weak, nonatomic)     id <SWSelectionSliderDataSource>    dataSource;
@property (weak, nonatomic)     id <SWSelectionSliderDelegate>      delegate;

@property (nonatomic)           NSInteger                           selectedIndex;

@property (strong, nonatomic)   UILabel                             *selectionLabel;

@property (strong, nonatomic)   SWSelectionSlidingView              *sliderView;
@property (strong, nonatomic)   UIScrollView                        *sliderScrollView;

@end
