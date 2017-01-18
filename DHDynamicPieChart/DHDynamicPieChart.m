//
//  DHDynamicPieChart.m
//  DHDynamicPieChart
//
//  Created by David Hu on 1/17/17.
//
//

#import "DHDynamicPieChart.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

static NSString * const LevelAnimationIDKey = @"levelAnimationIDKey";
static NSString * const LevelAnimationID = @"levelAnimationID";

@interface DHDynamicPieChart()<CAAnimationDelegate>
{
    NSUInteger _currentLevel;
    NSUInteger _levelCount;
    NSUInteger _animationLoopCount;
    NSUInteger _animationLoopCurrentIndex;
    UIColor *_currentLevelTintColor;
    
    NSMutableArray<CAShapeLayer *> *_levelCharts;
    NSMutableArray<CAShapeLayer *> *_levelChartsBackground;
    CABasicAnimation *_levelAnimation;
    
    void(^_delayAnimationBlock)();
}
@end

@implementation DHDynamicPieChart

- (instancetype)initWithLevel:(NSUInteger)levelCount {

    if (self = [super init]) {
        
        self.clipsToBounds = YES;
        
        _levelCount = levelCount;
        
        //---Default settings---
        _lineWidth = 38.0f;
        _levelBackgroundColor = [UIColor lightGrayColor];
        _animateDurationBySeconds = 0.5;
        _currentLevelTintColor = [UIColor lightGrayColor];
        _levelTintColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor greenColor]];
        //----------------------
        
        _levelAnimation = [self generateAnimationWithIdentifier:LevelAnimationID key:LevelAnimationIDKey];
    }
    
    return self;
}

- (void)setLevel:(NSUInteger)level animated:(BOOL)animated{
    
    if (level <= 0 || level > _levelCount) { return; }
    
    [self reset];
    _currentLevel = level;
    _currentLevelTintColor = [self colorOnLevel:level];
    
    if (animated) {
        _levelAnimation.duration = _animateDurationBySeconds / _levelCount;
        
        /*
         If client code calls the setLevel: method immediatelly after
         add the view on super view, delay the animation until the
         layoutSublayersOfLayer: is called so that chart will be
         correctly configured.
         */
        if (_levelCharts && _levelChartsBackground) {
            [self startAnimateToLevel:level];
        }
        else {
            __weak typeof(self) weakSelf = self;
            _delayAnimationBlock = ^(){
                [weakSelf startAnimateToLevel:level];
            };
        }
    }
    else {
        for (int i = 0; i < level; i++) {
            _levelCharts[i].strokeColor = _currentLevelTintColor.CGColor;
        }
    }
    
}

- (void)reset {
    
    for (CAShapeLayer *layer in _levelCharts) {
        
        layer.strokeColor = _levelBackgroundColor.CGColor;
        [layer removeAllAnimations];
    }
}

#pragma mark - Util

- (void)startAnimateToLevel:(NSUInteger)toLevel {
    
    _animationLoopCount = toLevel;
    _animationLoopCurrentIndex = 0;
    
    _levelCharts[_animationLoopCurrentIndex].strokeColor = _currentLevelTintColor.CGColor;
    [_levelCharts[_animationLoopCurrentIndex] addAnimation:_levelAnimation forKey:nil];
}

- (void)updateLevelChartWithStrokeColor:(UIColor *)color {
    
    for (CAShapeLayer *layer in _levelCharts) {
        
        layer.strokeColor = color.CGColor;
    }
}

- (CABasicAnimation *)generateAnimationWithIdentifier:(NSString *)identifier key:(NSString *)identifierKey {
    
    CABasicAnimation *animation = ({
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        ani.fromValue = @(0);
        ani.toValue = @(1);
        ani.duration = _animateDurationBySeconds;
        ani.delegate = self;
        [ani setValue:identifier forKey:identifierKey];
        ani;
    });
    
    return animation;
}

- (CAShapeLayer *)generateShapLayerWithPath:(UIBezierPath *)path {
    
    CAShapeLayer *shapeLayer = ({
        CAShapeLayer *v = [CAShapeLayer layer];
        v.frame = self.bounds;
        v.path = path.CGPath;
        v.fillColor = nil;
        v.strokeColor = _levelBackgroundColor.CGColor;
        v.lineWidth = _lineWidth;
        v.backgroundColor = [UIColor clearColor].CGColor;
        v;
    });
    
    return shapeLayer;
}

- (UIColor*)colorOnLevel:(NSUInteger)level {
    
    NSUInteger colorCount = MIN(_levelCount, _levelTintColors.count);
    NSUInteger index = ((CGFloat)(level - 1) / _levelCount) * colorCount;
    return _levelTintColors[index];
}

#pragma mark - CABasicAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        
        _animationLoopCurrentIndex++;
        
        if ([[anim valueForKey:LevelAnimationIDKey] isEqualToString:LevelAnimationID] && _animationLoopCurrentIndex < _animationLoopCount) {
            
            _levelCharts[_animationLoopCurrentIndex].strokeColor = _currentLevelTintColor.CGColor;
            [_levelCharts[_animationLoopCurrentIndex] addAnimation:_levelAnimation forKey:nil];
        }
    }
}

#pragma mark - System

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    
    [super layoutSublayersOfLayer:layer];
    
    if (_levelCharts && _levelChartsBackground) {
        
        [self updateChartsArrayWithCreateOperation:NO];
    }
    else {
        
        _levelCharts = [[NSMutableArray alloc] init];
        _levelChartsBackground = [[NSMutableArray alloc] init];
        
        [self updateChartsArrayWithCreateOperation:YES];
        
        if (_delayAnimationBlock) {
            _delayAnimationBlock();
            _delayAnimationBlock = nil;
        }
    }
}

- (void)updateChartsArrayWithCreateOperation:(BOOL)isCreate {
    
    CGFloat radius = MIN(self.frame.size.width / 2, self.frame.size.height / 2) - _lineWidth / 2;
    CGFloat space = DEGREES_TO_RADIANS(0.8f);
    CGPoint arcCenter = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    for (int i = 0; i < _levelCount; i++) {
        
        CGFloat totalAngle = self.endAngle - self.startAngle;
        CGFloat startAngle = self.startAngle + (CGFloat)i / _levelCount * totalAngle + space;
        CGFloat endAngle = self.startAngle + (CGFloat)(i + 1) / _levelCount * totalAngle - space;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                            radius:radius
                                                        startAngle:startAngle
                                                          endAngle:endAngle
                                                         clockwise:YES];
        
        if (isCreate) {
            
            CAShapeLayer *levelChartBackground = [self generateShapLayerWithPath:path];
            CAShapeLayer *levelChart = [self generateShapLayerWithPath:path];
            [self.layer addSublayer:levelChartBackground];
            [self.layer addSublayer:levelChart];
            
            [_levelCharts addObject:levelChart];
            [_levelChartsBackground addObject:levelChartBackground];
            
        }else {
            
            _levelCharts[i].path = path.CGPath;
            _levelCharts[i].frame = self.bounds;
            _levelChartsBackground[i].path = path.CGPath;
            _levelChartsBackground[i].frame = self.bounds;
        }
    }
}

@end
