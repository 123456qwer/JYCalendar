//
//  JYWeatherModel.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/19.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYWeatherModel : NSObject

@property (nonatomic ,copy)NSString *cityStr;


@property (nonatomic ,assign)int picIDD;
@property (nonatomic ,copy)NSString *weatherStrD;
@property (nonatomic ,copy)NSString *windStrD;
@property (nonatomic ,copy)NSString *tempD;

@property (nonatomic ,assign)int picIDN;
@property (nonatomic ,copy)NSString *weatherStrN;
@property (nonatomic ,copy)NSString *windStrN;
@property (nonatomic ,copy)NSString *tempN;


@end
