//
//  JYMainViewController.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/10.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYMainViewController : UIViewController

@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic ,strong)UIButton *rightBtn;


//隐藏选择日期按钮
- (void)hiddenAction:(BOOL)isHidden;


@end
