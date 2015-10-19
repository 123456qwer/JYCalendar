//
//  DataManager.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/14.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DataManager : NSObject

+ (DataManager *)shareDataManager;
- (BOOL)openDB;

//插入数据
- (void)insertActionWithYear:(int )year
                       month:(int )month
                         day:(int )day
                        hour:(int )hour
                      minute:(int )minute
                       title:(NSString *)title
                     content:(NSString *)content
                   timeorder:(NSString *)timeOrder;

//查询数据
- (NSArray *)selectAction;


@property (nonatomic)sqlite3 *database;
@property (nonatomic ,assign)BOOL isSuccess;

@end
