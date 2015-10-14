//
//  JYWeatherView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYWeatherView.h"

@implementation JYWeatherView


//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        
        
        _solarCalendar = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60,50)];
        _solarCalendar.backgroundColor = [UIColor orangeColor];
        _solarCalendar.text = @"2";
        _solarCalendar.font = [UIFont boldSystemFontOfSize:40];
        _solarCalendar.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_solarCalendar];
        
        
        _lunarCalendar = [[UILabel alloc] initWithFrame:CGRectMake(_solarCalendar.right + 5, 5, 100, 25)];
        _lunarCalendar.backgroundColor = [UIColor cyanColor];
        _lunarCalendar.text = @"八月初九";
        _lunarCalendar.font = [UIFont systemFontOfSize:16];
        _lunarCalendar.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lunarCalendar];
        
        
        _weekDay = [[UILabel alloc] initWithFrame:CGRectMake(_solarCalendar.right + 5, _lunarCalendar.bottom , 100, 25)];
        _weekDay.backgroundColor = [UIColor orangeColor];
        _weekDay.text = @"周三";
        _weekDay.font = [UIFont systemFontOfSize:15];
        _weekDay.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_weekDay];
        
        
        _holiDay = [[UILabel alloc] initWithFrame:CGRectMake(5, _solarCalendar.bottom + 5, kScreenWidth, 20)];
        _holiDay.backgroundColor = [UIColor orangeColor];
        _holiDay.text = @"赚钱节";
        _holiDay.font = [UIFont boldSystemFontOfSize:10];
        _holiDay.numberOfLines = 0;
        _holiDay.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_holiDay];
        
        
        _pointDay = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 100 / 2.0, 0, 100, 40)];
        _pointDay.backgroundColor = [UIColor orangeColor];
        _pointDay.text = @"春分";
        _pointDay.font = [UIFont boldSystemFontOfSize:20];
        _pointDay.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pointDay];
        
        
    }

    return self;

}


@end
