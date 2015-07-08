//
//  KYPullToCurveVeiw.m
//  AnimatedCurveDemo
//
//  Created by yangqitao on 15/7/8.
//  Copyright (c) 2015年 Kitten Yang. All rights reserved.
//

#import "KYPullToCurveVeiw.h"
#import "LabelView.h"
#import "CurveView.h"
#import "UIView+Convenient.h"


@interface KYPullToCurveVeiw()

@property(nonatomic,assign)CGFloat progress;
@property (nonatomic,weak)UIScrollView *associatedScrollView;
@property (nonatomic,copy)void(^refreshingBlock)(void);

@end


@implementation KYPullToCurveVeiw{
    
    LabelView *labelView;
    CurveView *curveView;

    BOOL willEnd;
    BOOL notTracking;
    BOOL loading;
}


#pragma mark -- Public Method

-(id)initWithAssociatedScrollView:(UIScrollView *)scrollView{
    
    self = [super initWithFrame:CGRectMake(scrollView.width/2-200/2, -100, 200, 100)];
    if (self) {
        
        self.associatedScrollView = scrollView;
        [self setUp];
        [self.associatedScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self.associatedScrollView insertSubview:self atIndex:0];
        
    }
    
    return self;
    
}


-(void)setProgress:(CGFloat)progress{
    
    if (!self.associatedScrollView.tracking) {
        labelView.loading = YES;
    }
    
    if (!willEnd && !loading ) {
        NSLog(@"progress:%f",progress);
        curveView.progress = labelView.progress = progress;
    }


    self.center = CGPointMake(self.center.x, -fabs(self.associatedScrollView.contentOffset.y+64)/2);
    
    
    CGFloat diff = fabs(self.associatedScrollView.contentOffset.y+64) - self.pullDistance + 10;
    NSLog(@"diff:%f",diff);
    
    if (diff > 0) {
        
        curveView.transform = CGAffineTransformMakeRotation(M_PI * (diff*4/180));
        
        if (!self.associatedScrollView.tracking) {
            if (!notTracking) {
                notTracking = YES;
                loading = YES;
//                labelView.loading = YES;
            
                //旋转...
                [self startLoading:curveView];
                NSLog(@"旋转");
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    self.associatedScrollView.contentInset = UIEdgeInsetsMake(self.pullDistance + 64, 0, 0, 0);
                    
                } completion:^(BOOL finished) {
                    
                    self.refreshingBlock();
                    
                }];
            }
        }
        

    }else{
        
        labelView.loading = NO;
        curveView.transform = CGAffineTransformIdentity;
        
    }
    
}


-(void)addRefreshingBlock:(void (^)(void))block{
    
    self.refreshingBlock = block;

}



-(void)triggerPulling{

#warning TODO

}



-(void)stopRefreshing{
    
    willEnd = YES;
    
    self.progress = 1.0;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0f;
        self.associatedScrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.alpha = 1.0f;
        willEnd = NO;
        notTracking = NO;
        loading = NO;
        labelView.loading = NO;
        [self stopLoading:curveView];
    }];

    
}

#pragma mark -- Helper Method

-(void)setUp{
    
    //一些默认参数
    self.pullDistance = 99;
    
    
    curveView = [[CurveView alloc]initWithFrame:CGRectMake(20, 0, 30, self.height)];
    [self insertSubview:curveView atIndex:0];
    
    
    labelView = [[LabelView alloc]initWithFrame:CGRectMake(curveView.right+ 10, curveView.y, 150, curveView.height)];
    [self insertSubview:labelView aboveSubview:curveView];
    
}




- (void)startLoading:(UIView *)rotateView
{
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 0.4f;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [rotateView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}


- (void)stopLoading:(UIView *)rotateView{
    
    [rotateView.layer removeAllAnimations];
    
}

#pragma mark -- KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        if (contentOffset.y + 64 <= 0) {
            
            self.progress = MAX(0.0, MIN(fabs(contentOffset.y+64)/self.pullDistance, 1.0));
        
        }
    }
}


#pragma dealloc
-(void)dealloc{
    
    [self.associatedScrollView removeObserver:self forKeyPath:@"contentOffset"];
    
}

@end
