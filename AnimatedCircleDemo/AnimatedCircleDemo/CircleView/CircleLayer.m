//
//  CircleLayer.m
//  AnimatedCircleDemo
//
//  Created by Kitten Yang on 7/23/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>

#define outsideRectSize 50

@interface CircleLayer()

@property (nonatomic,assign)CGRect outsideRect;

@end

@implementation CircleLayer


-(id)initWithLayer:(CircleLayer *)layer{
    self = [super initWithLayer:layer];
    if (self) {
        
        self.progress    = layer.progress;
        self.outsideRect = layer.outsideRect;
        
    }
    return self;
}


-(void)drawInContext:(CGContextRef)ctx{
    
    //外接矩形的中心坐标
//    CGPoint rectCenter = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width/2 , self.outsideRect.origin.y + self.outsideRect.size.height/2);
    
    
//    CGPoint pointA = CGPointMake(rectCenter.x ,self.currentRect.origin.y + extra);
//    CGPoint pointB = CGPointMake(self.scrollDirection == ScrollDirectionLeft ? rectCenter.x + self.currentRect.size.width/2 : rectCenter.x + self.currentRect.size.width/2 + extra*2 ,rectCenter.y);
//    CGPoint pointC = CGPointMake(rectCenter.x ,rectCenter.y + self.currentRect.size.height/2 - extra);
//    CGPoint pointD = CGPointMake(self.scrollDirection == ScrollDirectionLeft ? self.currentRect.origin.x - extra*2 : self.currentRect.origin.x, rectCenter.y);
    
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithRect:self.outsideRect];
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextDrawPath(ctx, kCGPathFillStroke); // 同时填充颜色和边界

}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    CGFloat origin_x = self.position.x - outsideRectSize/2 + (progress - 0.5)*(self.frame.size.width - outsideRectSize);
    CGFloat origin_y = self.position.y - outsideRectSize/2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    
    [self setNeedsDisplay];
}

@end
