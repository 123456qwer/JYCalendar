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
    
    NSInteger      _grayWeekNow;   //灰色部分的点击
    
    NSInteger      _nowDaysNumber; //当月天数
    
    NSInteger      _todayTag;      //当天的tag
    
    int            _changeYear;    //变化的年
    int            _changeMonth;   //变化的月
}

#pragma mark 初始化

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

       // [self createLine:date andMonth:month];
        
        [self createCalendarLabelWithMonth:month year:year];
        
    }

    return self;
}

#pragma mark 创建视图

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
    
    _changeYear = year;
    _changeMonth = month;
    
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
    _grayWeekNow = weekNow;
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
    
  
    
    //创建日历label
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
        
        //设置这个月当天的颜色
        int today = [[Tool actionForNowSingleDay:nil] intValue];
        
        //当前这个月份
        int NowMonth = [[Tool actionForNowMonth:nil] intValue];
        
        if (today + weekNow - 1 == i && NowMonth == monthNow) {
            
            labelForCalendar.layer.cornerRadius = 10.0;
            labelForCalendar.layer.masksToBounds = YES;
            labelForCalendar.backgroundColor = [UIColor colorWithRed:0.411 green:0.500 blue:0.374 alpha:1.000];
            _todayTag = kTagForCalendarLabel + i;
        }
        
        
        
        //判断这个月的总天数
        NSInteger days = [Tool actionForNowManyDay:monthNow year:yearNow];
        _nowDaysNumber = days;
        
        if (i >= weekNow && i - weekNow < days) {
            
            //************初始农历数据*******************************//
           
            [self actionForLunarDataWithDay:i - weekNow + 1 year:yearNow month:monthNow];
            
            
            //***************判断周几***********************************//
         
            NSDate *date = [Tool actionForReturnSelectedDateWithDay:i - weekNow + 1 Year:yearNow month:monthNow];
            NSInteger weekRedColor  = [Tool actionForNowDay:date];
            
            [self actionForTextColorWithLabel:labelForCalendar weekDay:weekRedColor];
            
            
            
            //*********************给日历添加内容****************************//
           
            NSInteger dayNow = i - weekNow + 1;
            NSMutableAttributedString *nowStr = [self returnActionForMutableStringWtihDay:(int)dayNow month:(int)monthNow year:(int)yearNow];
            
            labelForCalendar.attributedText = nowStr;
            
            
        }
        
        //判断上个月的总天数
        NSInteger beforeDay = [Tool actionForNowManyDay:beforeMonth year:yearNow];
        if (i < weekNow ) {
            
            //初始农历数据
            [self actionForLunarDataWithDay:beforeDay - weekNow + i + 1 year:yearNow month:beforeMonth];
            
            
            //***************判断周几***********************************//
            
            NSDate *date = [Tool actionForReturnSelectedDateWithDay:i - weekNow + 1 Year:yearNow month:monthNow];
            NSInteger weekRedColor  = [Tool actionForNowDay:date];
            
            [self actionForTextColorWithLabel:labelForCalendar weekDay:weekRedColor];

         
            //*********************给日历添加内容****************************//

            NSInteger dayNow = beforeDay - weekNow + i + 1;
            NSMutableAttributedString *nowStr = [self returnActionForMutableStringWtihDay:(int)dayNow month:(int)beforeMonth year:(int)yearNow];
            labelForCalendar.attributedText = nowStr;

            
            
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
            NSMutableAttributedString *nowStr = [self returnActionForMutableStringWtihDay:(int)dayNow month:(int)nextMonth year:(int)yearNow];
            labelForCalendar.attributedText = nowStr;
            
            

            
            
            
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

#pragma mark 返回label具体内容
- (NSMutableAttributedString *)returnActionForMutableStringWtihDay:(int )day
                                                   month:(int )month
                                                    year:(int )year
{
    
    //阴阳
    NSString *strForMonthLunar = [_lunarCalendar MonthLunar];
    NSString *strForDayLunar   = [_lunarCalendar DayLunar];
    
    //阴历日
    NSMutableAttributedString *attStrForDayLunar = [[NSMutableAttributedString alloc] initWithString:strForDayLunar];
    [attStrForDayLunar addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(0, attStrForDayLunar.length)];
    
    
    
    int lunarDay = 0;int lunarMonth = 0;
    
    NSArray  *arrayMonth = [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月",  @"十月", @"冬月", @"腊月", nil];
    
    NSArray  *arrayDay = [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十", @"三一", nil];
    
    
    
    for (int i = 0; i < arrayDay.count; i++) {
        
        NSString *strForLunarDay = arrayDay[i];
        
        if ([strForLunarDay isEqualToString:strForDayLunar]) {
            
            lunarDay = i;
        }
        
    }
    
    for (int i = 0; i < arrayMonth.count; i++) {
        
        NSString *strForLunarMonth = arrayMonth[i];
        
        if ([strForLunarMonth isEqualToString:strForMonthLunar]) {
            
            lunarMonth = i;
        }
        
    }
    
    //优先级
    //中国节日 1
    if (lunarMonth == 0) {
        
        lunarMonth = 1;
    }
    
    //中国节 1
    NSString *chineseHoliday = [_lunarCalendar getChineseHoliday:lunarDay day:lunarMonth];
    
    //节气 2
    NSString *strForPointDay   = [_lunarCalendar SolarTermTitle];
    
    //周节日 3
    NSString *holiday = [_lunarCalendar getWeekHoliday:year month:month day:day];
    
    //世界节日 4
    NSString *worldHoliday = [_lunarCalendar getWorldHoliday:month day:day];
    
    NSMutableAttributedString *attStrForNow = nil;
    
    if ([self isNotNULL:chineseHoliday]) {
        
        attStrForNow = [[NSMutableAttributedString alloc] initWithString:chineseHoliday];
        [attStrForNow addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(0, attStrForNow.length)];
        
   
    }else if([self isNotNULL:strForPointDay]){
    
        attStrForNow = [[NSMutableAttributedString alloc] initWithString:strForPointDay];
        [attStrForNow addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(0, attStrForNow.length)];
    
    }else if([self isNotNULL:holiday]){
    
        attStrForNow = [[NSMutableAttributedString alloc] initWithString:holiday];
        [attStrForNow addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(0, attStrForNow.length)];
    
    }else if([self isNotNULL:worldHoliday]){
    
        attStrForNow = [[NSMutableAttributedString alloc] initWithString:worldHoliday];
        [attStrForNow addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:NSMakeRange(0, attStrForNow.length)];

    }else{
    
        attStrForNow = attStrForDayLunar;
        
    }
    
    //阳历日
    NSString *nowDay = [NSString stringWithFormat:@"%d\n",day];
    NSMutableAttributedString *strForReturn = [[NSMutableAttributedString alloc] initWithString:nowDay];
    [strForReturn addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, strForReturn.length)];
    
    [strForReturn appendAttributedString:attStrForNow];
    
    return strForReturn;

    
}

//判断字符串是否为空
- (BOOL )isNotNULL:(NSString *)strForNow
{
    if (strForNow == nil || strForNow == NULL || [strForNow isEqualToString:@""]) {
        
        return NO;
        
    }else{
    
        return YES;
    }
   
}

#pragma mark 点击日历方法

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
   
    
    [self actionForBgColorWithTag:_beforeTag label:beforeLabel];
    
    _beforeTag = nowTag;
    
    NSLog(@"%@",label.text);
    
    //截取字符
    NSString *labelStr = label.text;
    NSArray *strarrayForH = [labelStr componentsSeparatedByString:@"\n"];
    
    NSString *strForHoliday = @"";
    NSString *strForSolar = strarrayForH[0];

    if (strarrayForH.count == 2) {
        
        strForHoliday = strarrayForH[1];
        
    }
    
    //根据tag判断时候是上个月或者下个月，不是本月
    //周日 = 1 周一 = 2 ...周六 = 7
    NSInteger tagForGrayLabel = 0;
    if (_grayWeekNow == 1) {
        
        tagForGrayLabel = 6;
        
    }else{
    
        tagForGrayLabel = _grayWeekNow - 2;
        
    }
    
    NSInteger isBefore = nowTag - kTagForCalendarLabel;
    NSInteger isNext   = nowTag - kTagForCalendarLabel - tagForGrayLabel + 1; //数组
    
    
    //在一号之前，证明是前一个月
    if (isBefore < tagForGrayLabel) {
        
        //星期
       NSString *strForWeek = [self actionForReturnSelectedWeek:[strForSolar intValue] month:_changeMonth - 1];
        
        //阴历日
        [self actionForLunarDataWithDay:[strForSolar intValue] year:_changeYear month:_changeMonth - 1];
        NSString *lunarDay = [_lunarCalendar DayLunar];
        
        //传值  1代表前一个月
        _calendarBlock(strForSolar,lunarDay,strForHoliday,1 ,strForWeek);
        
    }else if(isNext > _nowDaysNumber){
    
        //星期
        NSString *strForWeek = [self actionForReturnSelectedWeek:[strForSolar intValue] month:_changeMonth + 1];
        
        
        [self actionForLunarDataWithDay:[strForSolar intValue] year:_changeYear month:_changeMonth + 1];
        NSString *lunarDay = [_lunarCalendar DayLunar];
        //传值  2代表下一个月
        _calendarBlock(strForSolar,lunarDay,strForHoliday,2 ,strForWeek);
        
    }else{
        
        //星期
        NSString *strForWeek = [self actionForReturnSelectedWeek:[strForSolar intValue] month:_changeMonth];
        
        [self actionForLunarDataWithDay:[strForSolar intValue] year:_changeYear month:_changeMonth];
        NSString *lunarDay = [_lunarCalendar DayLunar];
        //传值  0代表这个月
        _calendarBlock(strForSolar,lunarDay,strForHoliday,0 ,strForWeek);

    }
    
   

    
   
    
}


//选中当天的星期
- (NSString *)actionForReturnSelectedWeek:(int )day
                                    month:(int )month
{

    NSDate *date = [Tool actionForReturnSelectedDateWithDay:day Year:(integer_t)_changeYear month:(integer_t)month];
    NSInteger week = [Tool actionForNowDay:date];
    NSArray *arrForWeek = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString *strForWeek = @"";
    if (week == 1) {
        
        strForWeek = arrForWeek[0];
        return strForWeek;
        
    }else{
        
        strForWeek = arrForWeek[week - 1];
        return strForWeek;
        
    }


}


//阴历
//**************************初始化阴历数据方法***********************//
- (void)actionForLunarDataWithDay:(NSInteger )day
                             year:(NSInteger )year
                            month:(NSInteger )month
{
    NSDate *dateForNow = [Tool actionForReturnSelectedDateWithDay:day Year:year month:month];
    [_lunarCalendar loadWithDate:dateForNow];
    [_lunarCalendar InitializeValue];
    

}


#pragma mark 私有方法，判断

//是否当天日期
- (void)actionForBgColorWithTag:(NSInteger )tag
                          label:(UILabel *)beforeLabel
{
   
    //当前这个月份
    int NowMonth = [[Tool actionForNowMonth:nil] intValue];
    
    
    if (_beforeTag != _todayTag) {
        
        beforeLabel.backgroundColor = [UIColor clearColor];
        
    }else if(NowMonth == _changeMonth){
        
        beforeLabel.backgroundColor = [UIColor colorWithRed:0.411 green:0.500 blue:0.374 alpha:1.000];
    }else{
        
        beforeLabel.backgroundColor = [UIColor clearColor];
    }


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
                           year:(int )year
{

    //阴阳
    NSString *strForMonthLunar = [_lunarCalendar MonthLunar];
    NSString *strForDayLunar   = [_lunarCalendar DayLunar];

    
    int lunarDay = 0;int lunarMonth = 0;
    
    NSArray  *arrayMonth = [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月",  @"十月", @"冬月", @"腊月", nil];
    
    NSArray  *arrayDay = [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十", @"三一", nil];
    
    for (int i = 0; i < arrayDay.count; i++) {
        
        NSString *strForLunarDay = arrayDay[i];
        
        if ([strForLunarDay isEqualToString:strForDayLunar]) {
            
            lunarDay = i;
        }
        
    }
    
    for (int i = 0; i < arrayMonth.count; i++) {
        
        NSString *strForLunarMonth = arrayMonth[i];
        
        if ([strForLunarMonth isEqualToString:strForMonthLunar]) {
            
            lunarMonth = i;
        }
        
    }
    
    //优先级
    //中国节日 1
    if (lunarMonth == 0) {
        
        lunarMonth = 1;
    }
    
    NSString *chineseHoliday = [_lunarCalendar getChineseHoliday:lunarDay day:lunarMonth];
    
    //节气 2
    NSString *strForPointDay   = [_lunarCalendar SolarTermTitle];
    
    //周节日 3
    NSString *holiday = [_lunarCalendar getWeekHoliday:year month:beforeMonth day:dayNow];
    
    //世界节日 4
    NSString *worldHoliday = [_lunarCalendar getWorldHoliday:beforeMonth day:dayNow];
    

    NSString *nowStr = @"";
   
    if (chineseHoliday == nil || chineseHoliday == NULL || [chineseHoliday isEqualToString:@""]) {
        
        if (strForPointDay == nil || strForPointDay == NULL || [strForPointDay isEqualToString:@""]) {
            
            if (holiday == nil || holiday == NULL || [holiday isEqualToString:@""]) {
                
                if (worldHoliday == nil || worldHoliday == NULL || [holiday isEqualToString:@""]) {
                    
                    nowStr = [NSString stringWithFormat:@"%@",strForDayLunar];
                    
                }else{
                    
                    nowStr = [NSString stringWithFormat:@"%@\n%@",strForDayLunar,worldHoliday];
                }
          
                
            }else{
                
                nowStr = [NSString stringWithFormat:@"%@\n%@",strForDayLunar,holiday];
                
            }
            
        }else{
            
            nowStr = [NSString stringWithFormat:@"%@\n%@",strForDayLunar,strForPointDay];
            
        }
        
        
    }else{
        
        nowStr = [NSString stringWithFormat:@"%@\n%@",strForDayLunar,chineseHoliday];
    }
    

    return nowStr;
    
}












@end
