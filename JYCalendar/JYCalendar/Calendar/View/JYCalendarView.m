//
//  JYCalendarView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/12.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYCalendarView.h"

@implementation JYCalendarView

{
   
    NSMutableArray *_arrForLine;
    
    NSMutableArray *_arrForLabel;
    
    NSMutableArray *_arrForBtn;
    
    LunarCalendar *_lunarCalendar;
    
    NSInteger      _beforeTag;
}


//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        
        //初始化数组
        _arrForLine = [NSMutableArray array];
        _arrForBtn  = [NSMutableArray array];
        _arrForLabel = [NSMutableArray array];
        
        _lunarCalendar = [[LunarCalendar alloc] init];
    
        
        //当天年月
        int month = [[Tool actionForNowMonth:[NSDate date]] intValue];
        int year  = [[Tool actionForNowYear:[NSDate date]] intValue];
      
        //当天1号日期
    
        NSDate *date = [Tool actionForReturnSelectedDateWithDay:1 Year:year month:month];

        [self createLine:date andMonth:month];
        
        [self createCalendarLabelWithMonth:month year:year];
        
    }

    return self;
}


//横竖线
- (void)createLine:(NSDate *)date
          andMonth:(int )month
{
    
    
  //删除之前的
    if (_arrForLine.count != 0) {
        
        for (int i = 0; i < _arrForLine.count; i ++) {
            
            UIView *viewB = _arrForLine[i];
            
            [viewB removeFromSuperview];
        }
        
        [_arrForLine removeAllObjects];
    }
    

    

    
    NSInteger weekNow  = [Tool actionForNowDay:date];
    
    
    int lineNumber = 0;
    if (weekNow == 1 && month != 2) {
        
        lineNumber = 7;
        
    }else{
    
        lineNumber = 6;
    }
    
    for (int i = 0;  i < lineNumber; i++) {
        
        UIView *viewForHline = [[UIView alloc] initWithFrame:CGRectMake(0, i * kHeightForCalendar, kScreenWidth, 0.5)];
        viewForHline.backgroundColor = [UIColor grayColor];
        [self addSubview:viewForHline];
        
        UIView *viewForVline = [[UIView alloc] initWithFrame:CGRectMake((i + 1) * kHeightForCalendar, 0, 0.5, (lineNumber - 1) * kHeightForCalendar)];
        viewForVline.backgroundColor = [UIColor grayColor];
        [self addSubview:viewForVline];
        
        [_arrForLine addObject:viewForVline];
        [_arrForLine addObject:viewForHline];
    }
    
}


//创建日期label
- (void)createCalendarLabelWithMonth:(int)month
                                year:(int)year
{
    
    //删除之前存储的
    if (_arrForLabel.count != 0) {
        
        for (int i = 0; i < _arrForLabel.count; i++) {
            
            UILabel *label = _arrForLabel[i];
            [label removeFromSuperview];
        }
        
        [_arrForLabel removeAllObjects];
    }
    
    if (_arrForBtn.count != 0) {
        
        for (int i = 0 ; i < _arrForBtn.count; i++) {
        
            UIButton *btn = _arrForBtn[i];
            [btn removeFromSuperview];
            
        }
        
        [_arrForBtn removeAllObjects];
    }
    
    
    //当前月
    int monthNow = month;
   
    //年份
    int yearNow = year;
    
    
    //下个月
    int nextMonth = 0;
    if (monthNow == 12) {
        
        nextMonth = 1;
    }else{
      
        nextMonth = monthNow + 1;
    }
    
    //上个月
    int beforeMonth = 0;
    if (monthNow == 1) {
        
        beforeMonth = 12;
    }else{
    
        beforeMonth = monthNow - 1;
    }
    
    
 
    NSDate *date = [Tool actionForReturnSelectedDateWithDay:1 Year:yearNow month:monthNow];

    NSInteger weekNow  = [Tool actionForNowDay:date];
    
    //周日 = 1 周一 = 2 ...周六 = 7
    
    //判断各数(有5行显示不下的情况)
    int numberForCalendar = 0;
    
    if (weekNow == 1 && month != 2) {
        
        numberForCalendar = 42;
        
    }else{
      
        numberForCalendar = 35;
    }
    
    if (weekNow == 1) {
        
        weekNow = 6;
        
    }else {
    
        weekNow -= 2;
        
    }
    
  
    
    
    for (int i = 0; i < numberForCalendar; i++) {
        
        int xForCalendar = i % 7;

        int yForCalendar = i / 7;
        
        UILabel *labelForCalendar = [[UILabel alloc] initWithFrame:CGRectMake(xForCalendar * kHeightForCalendar + 2, yForCalendar * kHeightForCalendar + 2, kHeightForCalendar - 4, kHeightForCalendar - 4)];
        labelForCalendar.textAlignment = NSTextAlignmentCenter;
        labelForCalendar.tag = kTagForCalendarLabel + i;
        labelForCalendar.userInteractionEnabled = YES;
        labelForCalendar.numberOfLines = 0;
        labelForCalendar.font = [UIFont systemFontOfSize:12];
        [self addSubview:labelForCalendar];
       
        
        //判断这个月的总天数
        NSInteger days = [Tool actionForNowManyDay:monthNow year:yearNow];
        if (i >= weekNow && i - weekNow < days) {
            
            //初始农历数据
            [self actionForLunarDataWithDay:i - weekNow + 1 year:yearNow month:monthNow];
            
            //判断周几
            NSDate *date = [Tool actionForReturnSelectedDateWithDay:i - weekNow + 1 Year:yearNow month:monthNow];
            NSInteger weekRedColor  = [Tool actionForNowDay:date];
            
            [self actionForTextColorWithLabel:labelForCalendar weekDay:weekRedColor];
            NSInteger dayNow = i - weekNow + 1;
            NSString *nowStr = [self actionForPointDay:(int)dayNow month:monthNow];
            
            labelForCalendar.text = [NSString stringWithFormat:@"%ld号\n%@",i - weekNow + 1,nowStr];
            
            
        }
        
        //判断上个月的总天数
        NSInteger beforeDay = [Tool actionForNowManyDay:beforeMonth year:yearNow];
        if (i < weekNow ) {
            
            //初始农历数据
            [self actionForLunarDataWithDay:beforeDay - weekNow + i + 1 year:yearNow month:beforeMonth];
            
            
            //判断周几
            NSDate *date = [Tool actionForReturnSelectedDateWithDay:i - weekNow + 1 Year:yearNow month:monthNow];
            NSInteger weekRedColor  = [Tool actionForNowDay:date];
            
            [self actionForTextColorWithLabel:labelForCalendar weekDay:weekRedColor];

            //国际节日
            NSInteger dayNow = beforeDay - weekNow + i + 1;
            NSString *nowStr = [self actionForPointDay:(int)dayNow month:beforeMonth];

            //日历内容
            labelForCalendar.text = [NSString stringWithFormat:@"%ld号\n%@",beforeDay - weekNow + i + 1,nowStr];
            
            //浅色红
            if (weekRedColor == 1 || weekRedColor == 7) {
                
                labelForCalendar.alpha = 0.5;
                
            }else{
                
                labelForCalendar.textColor = [UIColor grayColor];
                labelForCalendar.alpha = 0.5;

            }
        }
        
        //判断下个月的总天数
        if (i - weekNow >= days) {
            
            //初始农历数据
            [self actionForLunarDataWithDay:i - weekNow - days + 1 year:yearNow month:nextMonth];
            
            //判断周几
            NSDate *date = [Tool actionForReturnSelectedDateWithDay:i - weekNow + 1 Year:yearNow month:monthNow];
            NSInteger weekRedColor  = [Tool actionForNowDay:date];
            
            [self actionForTextColorWithLabel:labelForCalendar weekDay:weekRedColor];

            NSInteger dayNow = i - weekNow - days + 1;
            NSString *nowStr = [self actionForPointDay:(int)dayNow month:nextMonth];

            labelForCalendar.text = [NSString stringWithFormat:@"%ld号\n%@",i - weekNow - days + 1,nowStr];
            
            //浅色红
            if (weekRedColor == 1 || weekRedColor == 7) {
                
                labelForCalendar.alpha = 0.5;
                
            }else{
                
                labelForCalendar.textColor = [UIColor grayColor];
                labelForCalendar.alpha = 0.5;

            }
            
        }
        
  
        UIButton *btnForCalendar = [UIButton buttonWithType:UIButtonTypeCustom];
        btnForCalendar.frame = CGRectMake(0, 0, kHeightForCalendar, kHeightForCalendar);
        [btnForCalendar addTarget:self action:@selector(actionForClickCalendar:) forControlEvents:UIControlEventTouchUpInside];
        btnForCalendar.tag = kTagForCalendarBtn + i;
        [labelForCalendar addSubview:btnForCalendar];
        
        [_arrForBtn addObject:btnForCalendar];
        [_arrForLabel addObject:labelForCalendar];
        
    }
    
    
}


//点击日历方法
- (void)actionForClickCalendar:(UIButton *)sender
{
    if (_beforeTag == kTagForCalendarLabel + sender.tag - kTagForCalendarBtn) {
        
        return;
        
    }
    
    NSInteger nowTag = kTagForCalendarLabel + sender.tag - kTagForCalendarBtn;
    
    UILabel *label = (UILabel *)[self viewWithTag:nowTag];
    UILabel *beforeLabel = (UILabel *)[self viewWithTag:_beforeTag];
    
    label.backgroundColor = [UIColor greenColor];
    label.layer.cornerRadius = 10.0;
    label.layer.masksToBounds = YES;
    beforeLabel.backgroundColor = [UIColor clearColor];
    
    _beforeTag = nowTag;
    
    NSLog(@"%@",label.text);
}


//阴历
- (void)actionForLunarDataWithDay:(NSInteger )day
                             year:(NSInteger )year
                            month:(NSInteger )month
{
    NSDate *dateForNow = [Tool actionForReturnSelectedDateWithDay:day Year:year month:month];
    [_lunarCalendar loadWithDate:dateForNow];
    [_lunarCalendar InitializeValue];
    

}


//是否颜色加红
- (void)actionForTextColorWithLabel:(UILabel *)label
                            weekDay:(NSInteger )weekDay
{

    if (weekDay == 1 || weekDay == 7) {
        
        label.textColor = [UIColor redColor];
    }
}


//是否节气
- (NSString *)actionForPointDay:(int )dayNow
                          month:(int )beforeMonth
{
   
    
    //NSString *strForMonthLunar = [_lunarCalendar MonthLunar];
    NSString *strForDayLunar   = [_lunarCalendar DayLunar];
    NSString *strForPointDay   = [_lunarCalendar SolarTermTitle];
    NSString *holiday = [_lunarCalendar getWorldHoliday:beforeMonth day:(int )dayNow];
    NSString *nowStr = @"";
    if ([strForPointDay isEqualToString:@""]) {
        
        if (holiday == nil || holiday == NULL) {
            
            nowStr = strForDayLunar;
            
        }else{
        
            nowStr = [NSString stringWithFormat:@"%@\n%@",strForDayLunar,holiday];

        }
        
        
    }else{
        
        nowStr = strForPointDay;
    }
    

    return nowStr;
}












@end
