//
//  JYDatePicker.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/16.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Year)(NSInteger year);
typedef void(^Month)(NSInteger month);
typedef void(^Day)(NSInteger day);
typedef void(^Hour)(NSInteger hour);
typedef void(^Minute)(NSInteger minute);

@interface JYDatePicker : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic ,assign)NSInteger year;
@property (nonatomic ,assign)NSInteger month;
@property (nonatomic ,assign)NSInteger day;
@property (nonatomic ,assign)NSInteger hour;
@property (nonatomic ,assign)NSInteger minute;

@property (nonatomic ,copy)Year yearBlock;
@property (nonatomic ,copy)Month monthBlock;
@property (nonatomic ,copy)Day dayBlock;
@property (nonatomic ,copy)Hour hourBlock;
@property (nonatomic ,copy)Minute minuteBlock;

@end
