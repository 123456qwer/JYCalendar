//
//  Tool.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+ (NSString *)actionForNowDate
{
  
    NSDate *date = [[NSDate alloc] init];
    NSString *strForNowDate = [NSString stringWithFormat:@"%@",date];
    NSString *strYear = [strForNowDate substringWithRange:NSMakeRange(0, 4)];
    NSString *strMonth = [strForNowDate substringWithRange:NSMakeRange(5, 2)];
    NSString *strForNow = [NSString stringWithFormat:@"%@年%@月",strYear,strMonth];
    
    return strForNow;

}

+ (NSString *)actionForNowSingleDay:(NSDate *)date
{

    if (date == nil) {
        
        date = [NSDate date];
    }
    
    NSString *strForNowDate = [NSString stringWithFormat:@"%@",date];
    NSString *strForDay = [strForNowDate substringWithRange:NSMakeRange(8, 2)];
    
    return strForDay;
   
}

+ (NSString *)actionForNowYear:(NSDate *)date
{

    if (date == nil) {
        
        date = [NSDate date];
    }
    
    NSString *strForNowDate = [NSString stringWithFormat:@"%@",date];
    NSString *strYear = [strForNowDate substringWithRange:NSMakeRange(0, 4)];
    NSString *strForNow = [NSString stringWithFormat:@"%@",strYear];
  
    return strForNow;

}

+ (NSString *)actionForNowMonth:(NSDate *)date
{
  
    if (date == nil) {
        
        date = [NSDate date];
    }
    
    NSString *strForNowDate = [NSString stringWithFormat:@"%@",date];
    NSString *strMonth = [strForNowDate substringWithRange:NSMakeRange(5, 2)];
    NSString *strForNow = [NSString stringWithFormat:@"%@",strMonth];
    
    
    return strForNow;
}

+ (NSInteger )actionForNowWeek:(NSDate *)inputDate
{
  

 
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    
    return theComponents.weekday;
   

  
}

+ (NSInteger )actionForNowManyDay:(NSInteger )monthNow
                             year:(NSInteger )yearNow
{

    //判断这个月的总天数
    if (monthNow == 1 || monthNow == 3 || monthNow == 5 || monthNow == 7 || monthNow == 8 || monthNow == 10 || monthNow == 12) {
        
        return 31;
        
    }else if(monthNow == 2 && yearNow % 4 == 0){
     
        return 29;
        
    }else if(monthNow == 2 && yearNow % 4 != 0){
        
     
        return 28;
        
    }else{
    
        return 30;
        
    }

    
}

+ (NSDate *)actionForReturnSelectedDateWithDay:(NSInteger)day
                                          Year:(NSInteger)year
                                         month:(NSInteger)month
{

    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:day];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comp];

    return date;
}

+ (NSString *)actionforNowHour;
{
  
    NSDate *date = [NSDate date];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    
    NSInteger intForHour = [[str substringWithRange:NSMakeRange(11, 2)] integerValue];
    
    NSString *strForHour = [NSString stringWithFormat:@"%ld",intForHour + 8];
    
    return strForHour;
}

+ (NSString *)actionforNowMinute
{

    NSDate *date = [NSDate date];
    NSString *str = [NSString stringWithFormat:@"%@",date];
    
    NSString *strForMinute = [str substringWithRange:NSMakeRange(14, 2)] ;
    
    return strForMinute;

}

+ (NSDate *)actionForReturnSelectedDateWithDay:(NSInteger)day
                                          Year:(NSInteger)year
                                         month:(NSInteger)month
                                          hour:(NSInteger)hour
                                        minute:(NSInteger)minute
{

    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:day];
    [comp setHour:hour];
    [comp setMinute:minute];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:comp];
    
    return date;

}

+ (NSArray *)actionForReturnAlreadyAndAwaitArray
{
    DataManager *manager = [DataManager shareDataManager];
    
    NSDate *dateNow = [NSDate date];
    
    NSTimeInterval _secondDate = [dateNow timeIntervalSince1970]*1;
    
    
    NSMutableArray *arrForAlready = [NSMutableArray array];
    NSMutableArray *arrForAwait   = [NSMutableArray array];
    
    NSArray *arrForAll = [manager selectAction];
    
    for (int i = 0; i < arrForAll.count; i++) {
        
        RemindModel *model = arrForAll[i];
        
        NSDate *dateForRemind = [Tool actionForReturnSelectedDateWithDay:model.day Year:model.year month:model.month hour:model.hour minute:model.minute];
        
        NSTimeInterval _fitstDate = [dateForRemind timeIntervalSince1970]*1;
        
        //说明存储时间比现在时间晚，证明还未完成
        if (_fitstDate - _secondDate > 0) {
            
            [arrForAwait addObject:model];
            
        }else {
            
            //相反
            [arrForAlready addObject:model];
        }
        
        
        
    }
    
    NSArray *arrForAwaitAndAlready = @[arrForAwait,arrForAlready];
    
    
    return arrForAwaitAndAlready;
}


@end
