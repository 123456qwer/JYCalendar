//
//  JYSetUpViewController.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYSetUpViewController.h"

static JYSetUpViewController *_jySetUpVC = nil;

@interface JYSetUpViewController ()

@end

@implementation JYSetUpViewController

//单例
+ (instancetype)shareSetUp
{

    if (_jySetUpVC == nil) {
        
        _jySetUpVC = [[JYSetUpViewController alloc] init];
    }

    return _jySetUpVC;
}




/**
 *  生命周期
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
}

/**
 *  内存警告
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
