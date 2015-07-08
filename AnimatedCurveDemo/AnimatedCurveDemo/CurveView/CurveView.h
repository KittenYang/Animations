//
//  CurveView.h
//  AnimatedCurveDemo
//
//  Created by Kitten Yang on 7/6/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurveView : UIView

@property(nonatomic,assign)CGFloat progress;


-(id)initWithFrame:(CGRect)frame withAssociatedScrollView:(UIScrollView *)associatedScrollView;


@end
