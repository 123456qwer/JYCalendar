//
//  JYWeatherView.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYWeatherView : UIView

//阳历
@property (nonatomic ,strong)UILabel *solarCalendar;
//阴历
@property (nonatomic ,strong)UILabel *lunarCalendar;
//星期
@property (nonatomic ,strong)UILabel *weekDay;
//假期
@property (nonatomic ,strong)UILabel *holiDay;
//节气
@property (nonatomic ,strong)UILabel *pointDay;





@end
