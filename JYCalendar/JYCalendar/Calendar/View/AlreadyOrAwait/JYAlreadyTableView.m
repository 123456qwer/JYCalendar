//
//  JYAlreadyTableView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYAlreadyTableView.h"

@implementation JYAlreadyTableView

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
{
  
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
    }
    
    
    return self;
}



//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
    
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strForAlreadyCell = @"strForAlreadyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strForAlreadyCell];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strForAlreadyCell];
        cell.backgroundColor = [UIColor colorWithRed:0.449 green:0.446 blue:1.000 alpha:1.000];
    }
    
    return cell;
    
}


@end
