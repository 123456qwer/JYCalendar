//
//  Tool.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

/**
 *  算今天的日期
 *
 *  @return 如：2015年9月
 */
+ (NSString *)actionForNowDate;

/**
 *  返回当前的小时
 */
+ (NSString *)actionforNowHour;

/**
 *  返回当前分钟
 */
+ (NSString *)actionforNowMinute;

/**
 *  返回当天日期
 *
 *  @param date
 *
 *  @return 如13号
 */
+ (NSString *)actionForNowSingleDay:(NSDate *)date;

/**
 *  算当前月份
 */
+ (NSString *)actionForNowMonth:(NSDate *)date;

/**
 *  当前年份
 */
+ (NSString *)actionForNowYear:(NSDate *)date;

/**
 *  根据日期计算周几
 */
+ (NSInteger)actionForNowWeek:(NSDate *)inputDate;

/**
 *  当月天数
 */
+ (NSInteger )actionForNowManyDay:(NSInteger )monthNow year:(NSInteger )yearNow ;


/**
 *  根据年月日返回日期
 *
 *  @param day
 *  @param year
 *  @param month
 *
 *  @return date
 */
+ (NSDate *)actionForReturnSelectedDateWithDay:(NSInteger )day
                                          Year:(NSInteger )year
                                         month:(NSInteger )month;

/**
 *  返回精确的时间
 */
+ (NSDate *)actionForReturnSelectedDateWithDay:(NSInteger)day
                                          Year:(NSInteger)year
                                         month:(NSInteger)month
                                          hour:(NSInteger)hour
                                        minute:(NSInteger)minute;

/**
 *  返回俩个数组，0为未完成，1为完成的数组
 */
+ (NSArray *)actionForReturnAlreadyAndAwaitArray;


@end
