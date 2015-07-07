//
//  CurveLayer.m
//  AnimatedCurveDemo
//
//  Created by Kitten Yang on 7/6/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#define centerY 50
#define Radius  10

#import "CurveLayer.h"

@implementation CurveLayer

-(void)drawInContext:(CGContextRef)ctx{

    [super drawInContext:ctx];
    
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();

    //drawing...
    UIBezierPath *curvePath1 = [UIBezierPath bezierPath];
    curvePath1.lineCapStyle = kCGLineCapRound;
    curvePath1.lineJoinStyle = kCGLineJoinRound;
    curvePath1.lineWidth = 2.0f;
    [curvePath1 stroke];
    [curvePath1 moveToPoint:CGPointMake(self.frame.size.width/2-Radius, self.frame.size.height - (self.frame.size.height - centerY)*self.progress)];
    [curvePath1 addLineToPoint:CGPointMake(self.frame.size.width/2-Radius, centerY)];
    [curvePath1 addArcWithCenter:CGPointMake(self.frame.size.width/2, centerY) radius:Radius startAngle:M_PI endAngle:-M_PI*(1-self.progress) clockwise:YES];
    
    
    UIBezierPath *curvePath2 = [UIBezierPath bezierPath];
    curvePath2.lineCapStyle = kCGLineCapRound;
    curvePath2.lineJoinStyle = kCGLineJoinRound;
    curvePath2.lineWidth = 2.0f;
    [curvePath2 stroke];
    [curvePath2 moveToPoint:CGPointMake(self.frame.size.width/2+Radius, centerY*self.progress)];
    [curvePath2 addLineToPoint:CGPointMake(self.frame.size.width/2+Radius, centerY)];
    [curvePath2 addArcWithCenter:CGPointMake(self.frame.size.width/2, centerY) radius:Radius startAngle:0 endAngle:M_PI*self.progress clockwise:YES];
    

    
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    
    [[UIColor whiteColor] setStroke];
    [curvePath1 stroke];
    [curvePath2 stroke];
    
    UIGraphicsPopContext();




    
    
    
    
    
    
    
}

@end
