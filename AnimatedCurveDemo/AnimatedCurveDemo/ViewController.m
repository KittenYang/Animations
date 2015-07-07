//
//  ViewController.m
//  AnimatedCurveDemo
//
//  Created by Kitten Yang on 7/6/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "CurveView.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController{
    CurveView *curveView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

    
    curveView = [[CurveView alloc]init];
    curveView.backgroundColor = [UIColor grayColor];
    ;    curveView.center = self.view.center;
    curveView.bounds = CGRectMake(0, 0, 80, 80);
    [self.view addSubview:curveView];
    
}

- (void)sliderValueChanged:(UISlider *)sender {
    
    curveView.progress = sender.value;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
