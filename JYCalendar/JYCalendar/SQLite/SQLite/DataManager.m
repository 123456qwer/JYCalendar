//
//  DataManager.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/14.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "DataManager.h"

static DataManager *_dataManager = nil;

@implementation DataManager

+ (DataManager *)shareDataManager
{
   
    if (_dataManager == nil) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            _dataManager = [[DataManager alloc] init];
            
        });
        
    }
    
    return _dataManager;

}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataManager = [super allocWithZone:zone];
    });
    return _dataManager;
}


@end
