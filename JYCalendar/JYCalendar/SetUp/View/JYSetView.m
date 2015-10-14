//
//  JYSetView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/14.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYSetView.h"

@implementation JYSetView
{
   
    NSArray *_arrForBtn;  //设置按钮上

}


- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        _arrForBtn = @[@"夜间防扰模式（23：00 - 06：00）",@"快捷扫码",@"关于嘿咻",@"去评分",@"建议反馈"];
        
    }

    return self;
}



//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _arrForBtn.count;
    
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strForSetCell = @"strForSetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strForSetCell];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strForSetCell];
        cell.backgroundColor = [UIColor colorWithRed:0.449 green:0.446 blue:1.000 alpha:1.000];
        
    }
    
    cell.textLabel.text = _arrForBtn[indexPath.row];
    
    return cell;
    
}

@end
