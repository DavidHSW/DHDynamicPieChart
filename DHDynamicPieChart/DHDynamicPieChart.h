//
//  DHDynamicPieChart.h
//  DHDynamicPieChart
//
//  Created by David Hu on 1/17/17.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHDynamicPieChart : UIView

@property (nonatomic) CGFloat animateDurationBySeconds;
@property (nonatomic) CGFloat lineWidth;

/**
 *  Background level tint color. Not background of view.
 */
@property (nonatomic, strong) UIColor *levelBackgroundColor;

/**
 *  Color array that contains different levels' foreground tint color.
 *  If levelCount = a, levelTintColors.count = b, when set level to x, the tint color index should be ((x-1)/a)*b.
 */
@property (nonatomic, strong) NSArray<UIColor *> *levelTintColors;

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

- (instancetype)initWithLevel:(NSUInteger)levelCount;
- (void)setLevel:(NSUInteger)level animated:(BOOL)animated;
- (void)reset;

@end

NS_ASSUME_NONNULL_END
