//
//  SlideMenuButton.h
//  GooeySlideMenuDemo
//
//  Created by Kitten Yang on 15/8/13.
//  Copyright (c) 2015年 Kitten Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuButton : UIView


/**
 *  初始化方法
 *
 *  @param title title
 *
 *  @return 实例对象
 */
-(id)initWithTitle:(NSString *)title;

@property(nonatomic,strong)UIColor *buttonColor;

@end
