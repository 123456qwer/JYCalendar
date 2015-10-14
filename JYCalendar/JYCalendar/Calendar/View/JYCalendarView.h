//
//  JYCalendarView.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/12.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^calendarAction)(NSString *solarDay , NSString *lunarDay, NSString *holiday , int tagGray , NSString *weekDay);

@interface JYCalendarView : UIView

#pragma mark 加载新视图

//创建日期label
- (void)createCalendarLabelWithMonth:(int)month
                                year:(int)year;


//横竖线
- (void)createLine:(NSDate *)date
          andMonth:(int )month;

//传值block
@property (nonatomic ,copy)calendarAction calendarBlock;


@end
