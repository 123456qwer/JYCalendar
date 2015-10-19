//
//  JYRemindViewController.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYRemindViewController.h"
#import "JYRemindListTb.h"
#import "JYRemindDetailsView.h"

static JYRemindViewController *jyRemindVC = nil;

@interface JYRemindViewController ()

{
  
    JYRemindListTb *_listTableView; //日程列表
    JYRemindDetailsView *_detailView; //具体内容
    
    BOOL            _isSelected;
    
}

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

  
    //提醒按钮
    UIBarButtonItem *btnRightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加提醒" style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = btnRightItem;
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.title = @"计划清单";
    
    //日程列表
    [self createListTableView];
  
}

//添加方法
- (void)addAction:(UIButton *)sender
{
    _isSelected = !_isSelected;
   
    [_detailView changeContent];
    
    /*
    
    if (_isSelected) {
        
        _detailView = [[JYRemindDetailsView alloc] initWithFrame:CGRectMake(-kScreenWidth, 64, kScreenWidth, kScreenHeight - 64)];
        _detailView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_detailView];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _detailView.origin = CGPointMake(0, 64);
            
        }];
        
        [self.navigationItem.rightBarButtonItem setTitle:@"计划清单"];
        
        self.title = @"添加提醒";
        
        NSLog(@"添加");
  
    }else{
    
        [_detailView removeFromSuperview];

        [self.navigationItem.rightBarButtonItem setTitle:@"添加提醒"];
        
        self.title = @"计划清单";
        
        NSLog(@"添加");
    
    }
    
    */
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark 日程列表
- (void)createListTableView
{
    
//    _listTableView = [[JYRemindListTb alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
//    [self.view addSubview:_listTableView];

    _detailView = [[JYRemindDetailsView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _detailView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_detailView];

    
    //多余空格隐藏
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor clearColor];
    [_listTableView setTableFooterView:bgView];
    
    
}



#pragma mark 日程里主体内容

/**
 *  内存警告
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
