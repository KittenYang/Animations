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
    
    //外接虚线矩形
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:self.outsideRect];
    CGContextAddPath(ctx, rectPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(ctx, 1.0);
    CGFloat dash[] = {5.0, 5.0};
    CGContextSetLineDash(ctx, 0.0, dash, 2); //1
    CGContextStrokePath(ctx); //给线条填充颜色
    
    
    //圆的边界
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:self.outsideRect];
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0); //2
    CGContextDrawPath(ctx, kCGPathFillStroke); //同时给线条和线条包围的内部区域填充颜色
    
    //ctx字面意思是上下文，你可以理解为一块全局的画布。也就是说，一旦在某个地方改了画布的一些属性，其他任何使用画布的属性的时候都是改了之后的。比如上面在 //1 中把线条样式改成了虚线，那么在下文 //2 中如果不恢复成连续的直线，那么画出来的依然是//1中的虚线样式。

}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    CGFloat origin_x = self.position.x - outsideRectSize/2 + (progress - 0.5)*(self.frame.size.width - outsideRectSize);
    CGFloat origin_y = self.position.y - outsideRectSize/2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    
    [self setNeedsDisplay];
}

@end
