//
//  JYRemindView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYRemindView.h"

@implementation JYRemindView
{
   
    NSInteger _senderTag;

}


- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
  
        
        _btnForEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnForEdit.frame = CGRectMake(5, 5, 60, 30);
        [_btnForEdit addTarget:self action:@selector(actionForEdit:) forControlEvents:UIControlEventTouchUpInside];
        [_btnForEdit setTitle:@"编辑" forState:UIControlStateNormal];
        [self addSubview:_btnForEdit];
        
        
        _btnForAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnForAdd.frame = CGRectMake(kScreenWidth - 5 - 60, 5, 60, 30);
        [_btnForAdd addTarget:self action:@selector(actionForAdd:) forControlEvents:UIControlEventTouchUpInside];
        [_btnForAdd setTitle:@"添加" forState:UIControlStateNormal];
        [self addSubview:_btnForAdd];
        
    
        
        _btnForAwait = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnForAwait.frame = CGRectMake(kScreenWidth / 2.0 - 80, 0, 80, 40);
        [_btnForAwait addTarget:self action:@selector(actionForAwait:) forControlEvents:UIControlEventTouchUpInside];
        [_btnForAwait setTitle:@"待办" forState:UIControlStateNormal];
        _btnForAwait.backgroundColor = [UIColor colorWithRed:0.227 green:1.000 blue:0.092 alpha:1.000];
        [self addSubview:_btnForAwait];
        
        
        _btnForAlready = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnForAlready.frame = CGRectMake(_btnForAwait.right, 0, 80, 40);
        [_btnForAlready addTarget:self action:@selector(actionForAlready:) forControlEvents:UIControlEventTouchUpInside];
        [_btnForAlready setTitle:@"已提醒" forState:UIControlStateNormal];
        _btnForAlready.backgroundColor = [UIColor blackColor];
        [self addSubview:_btnForAlready];
        
        
        _alreayTableView = [[JYAlreadyTableView alloc] initWithFrame:CGRectMake(0, _btnForAwait.bottom + 1, kScreenWidth, 200 - 40) style:UITableViewStylePlain];
        _alreayTableView.hidden = YES;
        [self addSubview:_alreayTableView];
        
        
        _awaitTableView = [[JYAwaitTableView alloc] initWithFrame:CGRectMake(0, _btnForAwait.bottom + 1, kScreenWidth, 200 - 40) style:UITableViewStylePlain];
        _awaitTableView.hidden = NO;
        [self addSubview:_awaitTableView];
    
        
    }

    return self;
    
}

//选择待办的tb
- (void)actionForAwait:(UIButton *)sender
{

    _btnForAwait.backgroundColor = [UIColor colorWithRed:0.227 green:1.000 blue:0.092 alpha:1.000];
    _btnForAlready.backgroundColor = [UIColor blackColor];
    
    _awaitTableView.hidden = NO;
    _alreayTableView.hidden = YES;
    
    JYLog(@"选择了未完成tabel");
    
}


//选择已完成的tb
- (void)actionForAlready:(UIButton *)sender
{
    _btnForAwait.backgroundColor = [UIColor blackColor];
    _btnForAlready.backgroundColor = [UIColor colorWithRed:0.227 green:1.000 blue:0.092 alpha:1.000];
    
    _alreayTableView.hidden = NO;
    _awaitTableView.hidden = YES;
    JYLog(@"选择了完成table")
    
}


//编辑按钮
- (void)actionForEdit:(UIButton *)sender
{

    _editAction();
    JYLog(@"点击编辑按钮");
    
}

//增加新提醒按钮
- (void)actionForAdd:(UIButton *)sender
{

    _addAction();
    JYLog(@"点击添加新提醒按钮");
   
}



@end
