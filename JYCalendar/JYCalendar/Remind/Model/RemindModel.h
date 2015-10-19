//
//  RemindModel.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/16.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindModel : NSObject

@property (nonatomic ,assign)int year;
@property (nonatomic ,assign)int month;
@property (nonatomic ,assign)int day;
@property (nonatomic ,assign)int hour;
@property (nonatomic ,assign)int minute;
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,copy)NSString *content;
@property (nonatomic ,copy)NSString *timeorder;

@end
