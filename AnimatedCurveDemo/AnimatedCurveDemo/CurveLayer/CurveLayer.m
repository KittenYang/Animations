//
//  CurveLayer.m
//  AnimatedCurveDemo
//
//  Created by Kitten Yang on 7/6/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#define Radius  10
#define Space    1
#define LineLength 30
#define CenterY  self.frame.size.height/2

#import "CurveLayer.h"

@implementation CurveLayer

-(void)drawInContext:(CGContextRef)ctx{

    [super drawInContext:ctx];

    
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();

    //draw path
    
    //Path 1
    UIBezierPath *curvePath1 = [UIBezierPath bezierPath];
    curvePath1.lineCapStyle = kCGLineCapRound;
    curvePath1.lineJoinStyle = kCGLineJoinRound;
    curvePath1.lineWidth = 2.0f;
    if (self.progress <= 0.5) {
        [curvePath1 moveToPoint:CGPointMake(self.frame.size.width/2-Radius, CenterY - Space + LineLength + (1-2*self.progress)*(CenterY-LineLength))];
        [curvePath1 addLineToPoint:CGPointMake(self.frame.size.width/2-Radius, CenterY - Space + (1-2*self.progress)*(CenterY-LineLength))];
    }
    if (self.progress > 0.5) {
        [curvePath1 moveToPoint:CGPointMake(self.frame.size.width/2-Radius, CenterY - Space + LineLength - LineLength*(self.progress-0.5)*2)];
        [curvePath1 addLineToPoint:CGPointMake(self.frame.size.width/2-Radius, CenterY - Space)];
        [curvePath1 addArcWithCenter:CGPointMake(self.frame.size.width/2, CenterY-Space) radius:Radius startAngle:M_PI endAngle:M_PI + ((M_PI*9/10) * (self.progress-0.5)*2) clockwise:YES];
    }
    
    
    
    //Path 2
    UIBezierPath *curvePath2 = [UIBezierPath bezierPath];
    curvePath2.lineCapStyle = kCGLineCapRound;
    curvePath2.lineJoinStyle = kCGLineJoinRound;
    curvePath2.lineWidth = 2.0f;
    if (self.progress <= 0.5) {
        [curvePath2 moveToPoint:CGPointMake(self.frame.size.width/2+Radius, 2*self.progress * (CenterY + Space - LineLength))];
        [curvePath2 addLineToPoint:CGPointMake(self.frame.size.width/2+Radius,LineLength + 2*self.progress*(CenterY + Space - LineLength))];
    }
    if (self.progress > 0.5) {
        [curvePath2 moveToPoint:CGPointMake(self.frame.size.width/2+Radius, CenterY + Space - LineLength + LineLength*(self.progress-0.5)*2)];
        [curvePath2 addLineToPoint:CGPointMake(self.frame.size.width/2+Radius, CenterY + Space)];
        [curvePath2 addArcWithCenter:CGPointMake(self.frame.size.width/2, (CenterY+Space)) radius:Radius startAngle:0 endAngle:(M_PI*9/10)*(self.progress-0.5)*2 clockwise:YES];
    }
    
    

    CGContextSaveGState(context);
    CGContextRestoreGState(context);

    
    [[UIColor whiteColor] setStroke];
    [curvePath1 stroke];
    [curvePath2 stroke];
    
    UIGraphicsPopContext();




    
    
    
    
    
    
    
}

@end
