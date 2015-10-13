//
//  JYMainViewController.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

//controller
#import "JYMainViewController.h"
#import "JYRemindViewController.h"
#import "JYSetUpViewController.h"

//view
#import "JYCalendarView.h"
#import "JYWeatherView.h"

@interface JYMainViewController ()

{
    //View
    JYWeatherView          *_jyWeatherView;
    JYCalendarView         *_jyCalendarView;
    UIView                 *_weekView;

    
    //Controller
    JYRemindViewController *_jyRemaindVC;
    JYSetUpViewController  *_setUpVC;
    
    
    int                     _changeMonth;
    int                     _changeYear;
    
}

@end

@implementation JYMainViewController


#pragma mark 生命周期
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //一直更改的日期
    _changeMonth = [[Tool actionForNowMonth:[NSDate date]] intValue];
    _changeYear  = [[Tool actionForNowYear:[NSDate date]] intValue];


    self.view.backgroundColor = [UIColor cyanColor];
    self.title = [Tool actionForNowDate];

    //提醒按钮
    UIBarButtonItem *btnRightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加提醒" style:UIBarButtonItemStylePlain target:self action:@selector(addNewRemind)];
    self.navigationItem.rightBarButtonItem = btnRightItem;
    
    //设置按钮
    UIBarButtonItem *btnLeftItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
    self.navigationItem.leftBarButtonItem = btnLeftItem;
    
    [Tool actionForNowDay:nil];
    
    //星期
    [self createWeekView];
    
    //日历表格
    [self createCalendarView];
    
    //上下选择日期按钮
    [self createUpAndDownButton];
    
    //创建天气页面
    [self createWeatherView];
    

}

#pragma mark 选择日期按钮、方法

//选择日期按钮
- (void)createUpAndDownButton
{
   
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(80, 40, 20, 20);
    [_leftBtn addTarget:self action:@selector(actionForLeft:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.backgroundColor = [UIColor orangeColor];
    [self.navigationController.view addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(kScreenWidth - 100, 40, 20, 20);
    [_rightBtn addTarget:self action:@selector(actionForRight:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.backgroundColor = [UIColor greenColor];
    [self.navigationController.view addSubview:_rightBtn];

}

//向前
- (void)actionForLeft:(UIButton *)sender
{
    int beforeChangeMonth = _changeMonth;
    
    //减少月份
    if (_changeMonth == 1) {
        
        _changeMonth = 12;
        
    }else{
     
        _changeMonth--;
    }
    
    //增加年份
    if (beforeChangeMonth == 1 && _changeMonth == 12) {
        
        _changeYear--;
    }
    
    
    //是否增加行数
    NSDate *date = [Tool actionForReturnSelectedDateWithDay:1 Year:_changeYear month:_changeMonth];
    
    
    //改变日历
    [_jyCalendarView createCalendarLabelWithMonth:_changeMonth year:_changeYear];
    [_jyCalendarView createLine:date andMonth:_changeMonth];
    
    self.title = [NSString stringWithFormat:@"%d年%d月",_changeYear,_changeMonth];
    
    
    //是否改变天气View的高度
    BOOL isSix = [self isSixLineWithYear:_changeYear month:_changeMonth];
    [self actionForCollection:isSix];

    
    JYLog(@"向前翻");

}

//向后
- (void)actionForRight:(UIButton *)sender
{
    int beforeChangeMonth = _changeMonth;
    
    //增加月份
    if (_changeMonth == 12) {
        
        _changeMonth = 1;
        
    }else{
    
        _changeMonth++;
    }
    
    //增加年份
    if (beforeChangeMonth == 12 && _changeMonth == 1) {
        
        _changeYear++;
    }
   
    //是否增加行数
    NSDate *date = [Tool actionForReturnSelectedDateWithDay:1 Year:_changeYear month:_changeMonth];
    
    //改变日历
    [_jyCalendarView createCalendarLabelWithMonth:_changeMonth year:_changeYear];
    [_jyCalendarView createLine:date andMonth:_changeMonth];
    
    
    self.title = [NSString stringWithFormat:@"%d年%d月",_changeYear,_changeMonth];
    
    
    //是否改变天气View的高度
    BOOL isSix = [self isSixLineWithYear:_changeYear month:_changeMonth];
    [self actionForCollection:isSix];


    
    JYLog(@"向后翻");
 
}

#pragma mark 创建日期view

//星期
- (void)createWeekView
{
   
    _weekView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kHeightForWeek)];
    _weekView.backgroundColor = [UIColor whiteColor];
    CGFloat widthForWeek = kScreenWidth / 7.0;
    
    NSArray *arrForWeek = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for (int i = 0; i < arrForWeek.count; i++) {
        
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * widthForWeek, 0, widthForWeek, kHeightForWeek)];
        weekLabel.text = arrForWeek[i];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        
        if (i >= 5) {
            
            weekLabel.textColor = [UIColor redColor];
        }
        
        [_weekView addSubview:weekLabel];
    }
    
    [self.view addSubview:_weekView];
}

#pragma mark 创建日历View

//日历
- (void)createCalendarView
{
   
    _jyCalendarView = [[JYCalendarView alloc] initWithFrame:CGRectMake(0, _weekView.bottom + 0.5, kScreenWidth, 6 * kHeightForCalendar)];
    [self.view addSubview:_jyCalendarView];

}



/**
 *  设置方法
 */
- (void)setAction
{

    _setUpVC = [[JYSetUpViewController alloc] init];
    
    [self hiddenAction:YES];
    
    [self.navigationController pushViewController:_setUpVC animated:YES];

}


/**
 *  添加提醒方法
 */
- (void)addNewRemind
{
  
    _jyRemaindVC = [JYRemindViewController shareJYRemindVC];
    
    [self hiddenAction:YES];
    
    [self.navigationController pushViewController:_jyRemaindVC animated:YES];
    
    JYLog(@"123");

}


/**
 *  创建天气页面
 */
- (void)createWeatherView
{

    //当天年月
    int month = [[Tool actionForNowMonth:[NSDate date]] intValue];
    int year  = [[Tool actionForNowYear:[NSDate date]] intValue];
    BOOL isSix = [self isSixLineWithYear:year month:month];

    //天气页面
    if (isSix) {
        
    
        _jyWeatherView = [[JYWeatherView alloc] initWithFrame:CGRectMake(0, _jyCalendarView.bottom + 10, kScreenWidth, 80)];
        _jyWeatherView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_jyWeatherView];
        
    }else{
    
        
        _jyWeatherView = [[JYWeatherView alloc] initWithFrame:CGRectMake(0, _jyCalendarView.bottom + 10 - kHeightForCalendar, kScreenWidth, 80)];
        _jyWeatherView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_jyWeatherView];
    }
    

    
}

#pragma mark 隐藏选择日期按钮
- (void)hiddenAction:(BOOL)isHidden
{
   
    if (isHidden) {
        
        
            _leftBtn.alpha = 0;
            _rightBtn.alpha = 0;
            

        
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _leftBtn.alpha = 1;
            _rightBtn.alpha = 1;
            
        }];
    }

}

//视图将要出现调用
- (void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    
    [self hiddenAction:NO];
    
}

#pragma mark 判断是否有6行
- (BOOL)isSixLineWithYear:(int )year
                    month:(int )month
{
  
    
    NSDate *date = [Tool actionForReturnSelectedDateWithDay:1 Year:year month:month];
    NSInteger weekNow  = [Tool actionForNowDay:date];
    
    if (weekNow == 1 && month != 2) {
        
        return YES;
        
    }else{

        return NO;
    }
    
}

//收起天气View方法
- (void)actionForCollection:(BOOL)isSix
{
   
    if (isSix) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _jyWeatherView.origin = CGPointMake(0, _jyCalendarView.bottom + 10);
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _jyWeatherView.origin = CGPointMake(0, _jyCalendarView.bottom + 10 - kHeightForCalendar);
        }];
    
        
    }

}

//内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
