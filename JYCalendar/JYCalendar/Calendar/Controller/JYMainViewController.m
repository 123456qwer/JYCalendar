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
#import "JYRightAndWrongView.h"
#import "JYRemindView.h"

@interface JYMainViewController ()

{
    //View
    JYRemindView           *_jyRemindView;
    JYWeatherView          *_jyWeatherView;
    JYCalendarView         *_jyCalendarView;
    JYRightAndWrongView    *_jyRightAndWrongView;
    UIView                 *_weekView;

    
    //Controller
    JYRemindViewController *_jyRemaindVC;
    JYSetUpViewController  *_setUpVC;
    LunarCalendar          *_lunarCalendar;
    
    int                     _changeMonth;
    int                     _changeYear;
    
}

@end

@implementation JYMainViewController


#pragma mark 生命周期
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //添加编辑页面
    _jyRemaindVC = [JYRemindViewController shareJYRemindVC];

    
    //一直更改的日期
    _changeMonth = [[Tool actionForNowMonth:[NSDate date]] intValue];
    _changeYear  = [[Tool actionForNowYear:[NSDate date]] intValue];


    self.view.backgroundColor = [UIColor whiteColor];
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
    
    //创建宜忌页面
    [self createRightAndWrongView];
    
    //创建提醒页面
    [self createRemindView];

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
    //NSDate *date = [Tool actionForReturnSelectedDateWithDay:1 Year:_changeYear month:_changeMonth];
    
    
    //改变日历
    [_jyCalendarView createCalendarLabelWithMonth:_changeMonth year:_changeYear];
    //[_jyCalendarView createLine:date andMonth:_changeMonth];
    
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
   
//    //是否增加行数
//    NSDate *date = [Tool actionForReturnSelectedDateWithDay:1 Year:_changeYear month:_changeMonth];
    
    //改变日历
    [_jyCalendarView createCalendarLabelWithMonth:_changeMonth year:_changeYear];
    //[_jyCalendarView createLine:date andMonth:_changeMonth];
    
    
    self.title = [NSString stringWithFormat:@"%d年%d月",_changeYear,_changeMonth];
    
    
    //是否改变天气View的高度
    BOOL isSix = [self isSixLineWithYear:_changeYear month:_changeMonth];
    [self actionForCollection:isSix];


    
    JYLog(@"向后翻");
 
}

#pragma mark 创建星期view
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
    
    
    //传值
    [_jyCalendarView setCalendarBlock:^void(NSString *solarDay , NSString *lunarDay, NSString *holiday ,int tagGray ,NSString *weekDay){
    
        __block JYWeatherView *weatherView = _jyWeatherView;
        __block int changeYear = _changeYear;
        __block int changeMonth = _changeMonth;
        LunarCalendar *lunar = _lunarCalendar;
        
       
        
        
        int solarday = [solarDay intValue];
        
        if (tagGray == 1) {
            
            changeMonth--;
            
        }else if(tagGray == 2){
        
            changeMonth++;
            
        }else{
        
        
        }
        
    
        NSDate *date = [Tool actionForReturnSelectedDateWithDay:(integer_t)solarday  Year:(integer_t)changeYear month:(integer_t)changeMonth];
        
        [lunar loadWithDate:date];
        [lunar InitializeValue];
        
        NSString *lunarMonth = [lunar MonthLunar];
        
        weatherView.solarCalendar.text = solarDay;
        weatherView.lunarCalendar.text = [NSString stringWithFormat:@"%@%@",lunarMonth,lunarDay];
        weatherView.holiDay.text = holiday;
        weatherView.weekDay.text = weekDay;
    
    }];

}

#pragma mark 创建天气view
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
        
    
        _jyWeatherView = [[JYWeatherView alloc] initWithFrame:CGRectMake(0, _jyCalendarView.bottom + kPageForCalendar, kScreenWidth, kHeightForWeather)];
        _jyWeatherView.backgroundColor = [UIColor colorWithRed:0.231 green:0.824 blue:1.000 alpha:1.000];
        [self.view addSubview:_jyWeatherView];
        
        
    }else{
    
        
        _jyWeatherView = [[JYWeatherView alloc] initWithFrame:CGRectMake(0, _jyCalendarView.bottom + kPageForCalendar - kHeightForCalendar, kScreenWidth, kHeightForWeather)];
        _jyWeatherView.backgroundColor = [UIColor colorWithRed:0.376 green:0.717 blue:1.000 alpha:1.000];
        [self.view addSubview:_jyWeatherView];
        
    }
    
    //初始化数据
    _lunarCalendar = [[LunarCalendar alloc] init];
    [_lunarCalendar loadWithDate:nil];
    [_lunarCalendar InitializeValue];
    
    int day = [[Tool actionForNowSingleDay:[NSDate date]] intValue];
    
    
    //节日
    NSString *strForHoliday = [_lunarCalendar getWorldHoliday:month day:day];
    if (strForHoliday == nil || strForHoliday == NULL) {
        
        _jyWeatherView.holiDay.text = @"";
    }else{
    
        _jyWeatherView.holiDay.text = strForHoliday;
    }
    
    //日期
    _jyWeatherView.solarCalendar.text = [NSString stringWithFormat:@"%d",day];
    
    
    NSString *lunarMonth = [_lunarCalendar MonthLunar];
    NSString *lunarDay   = [_lunarCalendar DayLunar];
    //阴历
    _jyWeatherView.lunarCalendar.text = [NSString stringWithFormat:@"%@%@",lunarMonth,lunarDay];
    
    
    NSInteger weekDay = [Tool actionForNowDay:[NSDate date]];
    
    NSArray *arrForWeek = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    

    //星期
    //周日 = 1 周一 = 2 ...周六 = 7
    _jyWeatherView.weekDay.text = arrForWeek[weekDay - 1];
    
  
}


#pragma mark 创建宜忌view
/**
 *  创建宜忌页面
 */
- (void)createRightAndWrongView
{

    _jyRightAndWrongView = [[JYRightAndWrongView alloc] initWithFrame:CGRectMake(0, _jyWeatherView.bottom, kScreenWidth, kHeightForWeather)];
    _jyRightAndWrongView.backgroundColor = [UIColor colorWithRed:0.673 green:1.000 blue:0.854 alpha:1.000];
    [self.view addSubview:_jyRightAndWrongView];
    
}

#pragma mark 创建编辑提醒view
/**
 *  创建提醒页面
 */
- (void)createRemindView
{
    
    _jyRemindView = [[JYRemindView alloc] initWithFrame:CGRectMake(0, _jyRightAndWrongView.bottom + kPageForCalendar, kScreenWidth, 200)];
    _jyRemindView.backgroundColor = [UIColor colorWithRed:0.139 green:0.147 blue:1.000 alpha:1.000];
    [self.view addSubview:_jyRemindView];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeActionUpOrDown:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeActionUpOrDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    
    [_jyRemindView setEditAction:^void{
    
       
        
    }];
    
    
    __block JYRemindViewController *vc = _jyRemaindVC;
    __block JYMainViewController   *mainVC = self;
    
    
    [_jyRemindView setAddAction:^void{

        [mainVC hiddenAction:YES];
        
        [mainVC.navigationController pushViewController:vc animated:YES];
        
    }];
    
}


- (void)swipeActionUpOrDown:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        
   
        
        [UIView animateWithDuration:0.5 animations:^{
           
            _jyWeatherView.origin = CGPointMake(0, _weekView.bottom + kHeightForCalendar);
            _jyRightAndWrongView.origin = CGPointMake(0, _jyWeatherView.bottom);
            _jyRemindView.frame  = CGRectMake(0, _jyRightAndWrongView.bottom, kScreenWidth, 400);
          } completion:^(BOOL finished) {
            
              [UIView animateWithDuration:0.3 animations:^{
                  
                  _jyRemindView.alreayTableView.height = 400;
                  _jyRemindView.awaitTableView.height = 400;
                  
              }];
              
        }];
        
    }else{
    
        //是否改变天气View的高度
        BOOL isSix = [self isSixLineWithYear:_changeYear month:_changeMonth];
        [self actionForCollection:isSix];
        

    }
    
   
    
    JYLog(@"滑动了");
    
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


#pragma mark 超出6行调用方法
//收起天气View方法
- (void)actionForCollection:(BOOL)isSix
{
   
    if (isSix) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _jyWeatherView.origin = CGPointMake(0, _jyCalendarView.bottom + 10);
            _jyRightAndWrongView.origin = CGPointMake(0, _jyWeatherView.bottom);
            _jyRemindView.frame  = CGRectMake(0, _jyRightAndWrongView.bottom, kScreenWidth, 200);
            _jyRemindView.alreayTableView.height = 200;
            _jyRemindView.awaitTableView.height = 200;
        }];
        
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _jyWeatherView.origin = CGPointMake(0, _jyCalendarView.bottom + 10 - kHeightForCalendar);
            _jyRightAndWrongView.origin = CGPointMake(0, _jyWeatherView.bottom);
            _jyRemindView.frame  = CGRectMake(0, _jyRightAndWrongView.bottom, kScreenWidth, 200);
            _jyRemindView.alreayTableView.height = 200;
            _jyRemindView.awaitTableView.height = 200;

        }];
    
        
    }

}

#pragma mark push方法
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
    
    
    [self hiddenAction:YES];
    
    [self.navigationController pushViewController:_jyRemaindVC animated:YES];
    
    JYLog(@"123");
    
}


//内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
