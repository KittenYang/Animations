# Animations

A few of test animations.

一些动画的飞机稿，都是一些单独分离出来的用于测试的子动画，现在统一归类一下。

# 1. AnimatedCurveDemo


![](curverAnim_2.gif)

###Usage:

```objc

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //下拉刷新 Pull down to refresh
    KYPullToCurveVeiw *headerView = [[KYPullToCurveVeiw alloc]initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
    __weak KYPullToCurveVeiw *weakHeaderView = headerView;
    [headerView triggerPulling];
    [headerView addRefreshingBlock:^{
        
        //具体的操作
        //...
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakHeaderView stopRefreshing];
            
        });
        
    }];
    
    
    //上拉刷新 Pull up to refresh
    KYPullToCurveVeiw_footer *footerView = [[KYPullToCurveVeiw_footer alloc]initWithAssociatedScrollView:self.tableView withNavigationBar:YES];
    __weak KYPullToCurveVeiw_footer *weakFooterView= footerView;
    [footerView addRefreshingBlock:^{
        //具体的操作
        //...
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakFooterView stopRefreshing];
            
        });
        
    }];

    
}



```

---

---


# 2. AnimatedCircleDemo

![](circleAnim.gif)

A transformable layer with progress control. 
