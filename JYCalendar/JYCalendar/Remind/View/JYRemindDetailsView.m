//
//  JYRemindDetailsView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/15.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYRemindDetailsView.h"
#import "JYDatePicker.h"

@implementation JYRemindDetailsView
{
   
    UITextField  *_titleTextFiled;
    UITextField  *_contentTextFiled;
    UILabel      *_labelForTime;
    JYDatePicker *_datePicker;

    
    BOOL          _isHidden;
}
- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        
        
        
        [self createTitleTextFiled];
        
        [self createTimeSelect];
        
        [self createContentTextFiled];
        
    }
    
    return self;
}


//创建标题
- (void)createTitleTextFiled
{
  
    _titleTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 30)];
    _titleTextFiled.placeholder = @"请输入标题...";
    _titleTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:_titleTextFiled];
    
}

//创建选择时间的方法
- (void)createTimeSelect
{
  
    _labelForTime = [[UILabel alloc]initWithFrame:CGRectMake(10, _titleTextFiled.bottom + 10, kScreenWidth - 20, 40)];
    _labelForTime.text = @"请点击选择时间";
    _labelForTime.textAlignment = NSTextAlignmentCenter;
    _labelForTime.font = [UIFont boldSystemFontOfSize:18];
    _labelForTime.backgroundColor = [UIColor cyanColor];
    _labelForTime.userInteractionEnabled = YES;
    [self addSubview:_labelForTime];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, kScreenWidth-20, 40);
    [btn addTarget:self action:@selector(actionForDatePicker:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [_labelForTime addSubview:btn];
    
    
    _datePicker = [[JYDatePicker alloc] initWithFrame:CGRectMake(0, _labelForTime.bottom, kScreenWidth, 20)];
    _datePicker.alpha = 0;
    NSInteger year = [[Tool actionForNowYear:nil] integerValue];
    NSInteger month = [[Tool actionForNowMonth:nil] integerValue];
    NSInteger day  = [[Tool actionForNowSingleDay:nil] integerValue];
    NSInteger hour = [[Tool actionforNowHour] integerValue];
    NSInteger minute = [[Tool actionforNowMinute] integerValue];
    
    [_datePicker selectRow:year - 2015  inComponent:0 animated:YES];
    [_datePicker selectRow:month - 1 inComponent:1 animated:YES];
    [_datePicker selectRow:day - 1 inComponent:2 animated:YES];
    [_datePicker selectRow:hour - 1 inComponent:3 animated:YES];
    [_datePicker selectRow:minute - 1 inComponent:4 animated:YES];
    
    _datePicker.year = year;
    _datePicker.month = month;
    _datePicker.day = day;
    _datePicker.hour = hour;
    _datePicker.minute = minute;
    
    [self addSubview:_datePicker];
    
}

//将时间Label的内容改变
- (void)actionForDatePicker:(UIButton *)sender
{
    
    NSInteger year = _datePicker.year;
    NSInteger month = _datePicker.month;
    NSInteger day  = _datePicker.day;
    NSInteger hour = _datePicker.hour;
    NSInteger minute = _datePicker.minute;

    if (_isHidden) {
        
        _datePicker.alpha = 0;
        _isHidden = NO;
        _labelForTime.text = [NSString stringWithFormat:@"%ld-%ld-%ld    |    %ld:%ld",year,month,day,hour,minute];

    }else{
      
        _datePicker.alpha = 1;
        _isHidden = YES;
    }


    

}

//创建内容
- (void)createContentTextFiled
{

    _contentTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, _labelForTime.bottom + 10, kScreenWidth - 20, 400)];
    _contentTextFiled.placeholder = @"请输入内容";
    _contentTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self insertSubview:_contentTextFiled belowSubview:_datePicker];
    
}

//点击增加提醒按钮
- (void)changeContent
{
//    @property (nonatomic ,assign)int year;
//    @property (nonatomic ,assign)int month;
//    @property (nonatomic ,assign)int day;
//    @property (nonatomic ,assign)int hour;
//    @property (nonatomic ,assign)int minute;
//    @property (nonatomic ,copy)NSString *title;
//    @property (nonatomic ,copy)NSString *content;
//    @property (nonatomic ,copy)NSString *timeorder;
    
    RemindModel *model = [[RemindModel alloc] init];
    
    int year = (int )_datePicker.year;
    int month = (int )_datePicker.month;
    int day  = (int )_datePicker.day;
    int hour = (int )_datePicker.hour;
    int minute = (int )_datePicker.minute;
    
    model.year = (int )_datePicker.year;
    model.month = (int )_datePicker.month;
    model.day = (int )_datePicker.day;
    model.hour = (int )_datePicker.hour;
    model.minute = (int )_datePicker.minute;
    model.title = _titleTextFiled.text;
    model.content = _contentTextFiled.text;
    NSString *orderStr = [NSString stringWithFormat:@"%d-%d-%d-%d-%d",year,month,day,hour,minute];
    model.timeorder = orderStr;
    
    DataManager *data = [DataManager shareDataManager];
    
    [data insertActionWithYear:year month:month day:day hour:hour minute:minute title:_titleTextFiled.text content:_contentTextFiled.text timeorder:orderStr];
    
    _labelForTime.text = @"请点击选择时间";
    
    JYLog(@"添加");
    
}

@end
