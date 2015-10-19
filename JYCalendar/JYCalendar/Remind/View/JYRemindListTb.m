//
//  JYRemindListTb.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/15.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYRemindListTb.h"

@implementation JYRemindListTb
{
    NSArray  *_arrForAll;
    NSArray *_arrForAlready;
    NSArray *_arrForAwait;

}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
   
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        _arrForAll = [Tool actionForReturnAlreadyAndAwaitArray];
        
        _arrForAwait = _arrForAll[0];
        _arrForAlready = _arrForAll[1];
        
    }
    
    return self;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 0.1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UILabel *labelForHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    labelForHeader.textAlignment = NSTextAlignmentJustified;
    if (section == 0) {
        
        labelForHeader.text = @"未完成提醒";
    
        
    }else{
      
        labelForHeader.text = @"已完成提醒";
    }
    
    return labelForHeader;
    
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 2;

}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arrForAll.count > 0) {
        
        if (section == 0) {
            
            return _arrForAwait.count;
        }else{
        
            return _arrForAlready.count;
        }
        
    }else{
    
        return 3;

    }
    
    
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *strForListCell = @"strForListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strForListCell];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strForListCell];
        
    }
    
    if (indexPath.section == 0) {
        
        RemindModel *model = _arrForAwait[indexPath.row];
        
        cell.textLabel.text = model.title;
        cell.textLabel.text = [NSString stringWithFormat:@"%d-%d-%d-%@",model.year,model.month,model.day,model.title];
    }
    
    if (indexPath.section == 1) {
        
        RemindModel *model = _arrForAlready[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%d-%d-%d-%@",model.year,model.month,model.day,model.title];
    }
    
    return cell;
    
}



@end
