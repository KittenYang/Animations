//
//  CurveView.m
//  AnimatedCurveDemo
//
//  Created by Kitten Yang on 7/6/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "CurveView.h"
#import "CurveLayer.h"


@interface CurveView()

@property (nonatomic,strong)CurveLayer *curveLayer;
@property (nonatomic,weak)UIScrollView *associatedScrollView;

@end

@implementation CurveView


+ (Class)layerClass{
    return [CurveLayer class];
}

-(id)initWithFrame:(CGRect)frame withAssociatedScrollView:(UIScrollView *)associatedScrollView{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.associatedScrollView = associatedScrollView;
        [self.associatedScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        NSLog(@"KVO:%@",NSStringFromCGPoint(contentOffset));
        
        if (contentOffset.y + 64 <= 0) {

            self.progress = MAX(0, MIN(ABS(contentOffset.y+64)/130, 1));
        }
    }
}


-(void)setProgress:(CGFloat)progress{
    self.curveLayer.progress = progress;
    [self.curveLayer setNeedsDisplay];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{

    self.curveLayer = [CurveLayer layer];
    self.curveLayer.frame = self.bounds;
    self.curveLayer.contentsScale = [UIScreen mainScreen].scale;
    self.curveLayer.progress = 0.0f;
    [self.curveLayer setNeedsDisplay];
    [self.layer addSublayer:self.curveLayer];
    
}

-(void)dealloc{
    
    [self.associatedScrollView removeObserver:self forKeyPath:@"contentOffset"];
}



@end
