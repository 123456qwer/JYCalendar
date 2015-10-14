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
 *  根据日期计算周几
 *
 *  @param inputDate 日期
 *
 *  @return 周
 */
+ (NSInteger)actionForNowDay:(NSDate *)inputDate;

/**
 *  算当前月份
 *
 *  @param date 当前日期
 *
 *  @return 月
 */
+ (NSString *)actionForNowMonth:(NSDate *)date;


/**
 *  当前年份
 *
 *  @param date
 *
 *  @return 
 */
+ (NSString *)actionForNowYear:(NSDate *)date;


/**
 *  当月天数
 *
 *  @param month 月份
 *
 *  @return 返回天数
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
 *  返回当天日期
 *
 *  @param date
 *
 *  @return 如13号
 */
+ (NSString *)actionForNowSingleDay:(NSDate *)date;



@end
