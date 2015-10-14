//
//  JYRightAndWrongView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYRightAndWrongView.h"

@implementation JYRightAndWrongView

- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        
        _lunarDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, kScreenWidth, 11)];
        _lunarDayLabel.text = @"乙未[年]年 乙酉日 庚子时 壬午时";
        _lunarDayLabel.backgroundColor = [UIColor colorWithRed:1.000 green:0.609 blue:0.476 alpha:1.000];
        _lunarDayLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_lunarDayLabel];
        
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _lunarDayLabel.bottom + 5, kScreenWidth, 30)];
        _rightLabel.text = @"宜：123123123123123";
        _rightLabel.backgroundColor = [UIColor colorWithRed:1.000 green:0.402 blue:0.931 alpha:1.000];
        [self addSubview:_rightLabel];
        
        _wrongLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _rightLabel.bottom , kScreenWidth, 30)];
        _wrongLabel.text = @"忌：！23123123123123";
        _wrongLabel.backgroundColor = [UIColor colorWithRed:0.729 green:0.287 blue:1.000 alpha:1.000];
        [self addSubview:_wrongLabel];
        
        
    }
    
    return self;
}

@end
