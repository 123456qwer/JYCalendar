//
//  JYRemindView.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAlreadyTableView.h"
#import "JYAwaitTableView.h"

typedef void(^editAction)();
typedef void(^addAction)();

@interface JYRemindView : UIView

@property (nonatomic ,strong)UIButton *btnForAlready;
@property (nonatomic ,strong)UIButton *btnForAwait;

@property (nonatomic ,strong)UIButton *btnForEdit;
@property (nonatomic ,strong)UIButton *btnForAdd;

@property (nonatomic ,strong)JYAlreadyTableView *alreayTableView;
@property (nonatomic ,strong)JYAwaitTableView   *awaitTableView;

@property (nonatomic ,copy)editAction editAction;
@property (nonatomic ,copy)addAction addAction;


@end
