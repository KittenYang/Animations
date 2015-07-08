//
//  ViewController.m
//  AnimatedCurveDemo
//
//  Created by Kitten Yang on 7/6/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Convenient.h"

#import "KYPullToCurveVeiw.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation ViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    [self.tableView layoutIfNeeded];

    
    
    
    KYPullToCurveVeiw *headerView = [[KYPullToCurveVeiw alloc]initWithAssociatedScrollView:self.tableView];

    __weak KYPullToCurveVeiw *weakHeaderView = headerView;

    [headerView addRefreshingBlock:^{
        
        //具体的操作
        //...
    
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
            [weakHeaderView stopRefreshing];
            
        });

    }];
    
    [self.tableView insertSubview:headerView atIndex:0];

    
    
}





#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *testCell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    testCell.textLabel.text = [NSString stringWithFormat:@"第%ld条",(long)indexPath.row];
    return testCell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
