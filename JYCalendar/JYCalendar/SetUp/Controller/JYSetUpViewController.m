//
//  JYSetUpViewController.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYSetUpViewController.h"
#import "JYSetView.h"

static JYSetUpViewController *_jySetUpVC = nil;

@interface JYSetUpViewController ()
{
   
    JYSetView *_jySetView;

}
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
    self.title = @"设置";
    
    //创建tableView
    [self createTabelView];
    
    
}


/**
 *  创建tableView
 */
- (void)createTabelView
{
   
    _jySetView = [[JYSetView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_jySetView];

    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor clearColor];
    
    [_jySetView setTableFooterView:bgView];
}


/**
 *  内存警告
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
