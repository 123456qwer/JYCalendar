//
//  JYAwaitTableView.h
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYAwaitTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
                   andWaitArr:(NSArray *)arrForWait;

@property (nonatomic ,strong)NSArray *arrForWait;


@end
