//
//  JYRemindViewController.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYRemindViewController.h"

static JYRemindViewController *jyRemindVC = nil;

@interface JYRemindViewController ()

@end

@implementation JYRemindViewController

//单例
+ (instancetype)shareJYRemindVC
{
   
    if (jyRemindVC == nil) {
        
        jyRemindVC = [[JYRemindViewController alloc] init];
        
    }

    return jyRemindVC;
}

/**
 *  生命周期
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor cyanColor];
}


/**
 *  内存警告
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
