//
//  DataManager.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/14.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "DataManager.h"
#import "RemindModel.h"


static DataManager *_dataManager = nil;

@implementation DataManager

+ (DataManager *)shareDataManager
{
   
    if (_dataManager == nil) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            _dataManager = [[DataManager alloc] init];
            
        });
        
    }
    
    return _dataManager;

}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataManager = [super allocWithZone:zone];
    });
    return _dataManager;
}

//初始化数据库
- (instancetype)init
{
   
    if (self = [super init]) {
        
        _isSuccess = [self openDB];
    }

    return self;
}

#pragma mark 打开&创建数据库
- (BOOL)openDB
{
  
    //创建路径
    NSString *pathStr = [self filePath];
    
    JYLog(@"%@",pathStr);
    
    //文件管家
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:pathStr];
    
    //存在数据库的情况
    if (find) {
        
        JYLog(@"直接打开数据库");
        
        if (sqlite3_open([pathStr UTF8String], &_database) != SQLITE_OK) {
            
            //进入这里说明打开失败
            sqlite3_close(_database);
            
            JYLog(@"打开失败");
            
            return NO;
            
        }
        
        return YES;
        
    }
    
    
    if(sqlite3_open([pathStr UTF8String], &_database) == SQLITE_OK){
        //创建一个新表
        BOOL isSuccess = [self createNewSQL:_database];
        
//        //插入数据
//        [self insertActionWithYear:2015 month:5 day:3 hour:5 minute:25 title:@"记得提醒我喝水" content:@"喝水喝水喝水" timeorder:@"2013-21-13"];
        
        JYLog(@"创建数据库");
        
        return isSuccess;
        
    }else{
    
        sqlite3_close(_database);
        _isSuccess = NO;
        return NO;
    }
    

}

#pragma mark 操作数据库

//插入数据
- (void)insertActionWithYear:(int )year
                       month:(int )month
                         day:(int )day
                        hour:(int )hour
                      minute:(int )minute
                       title:(NSString *)title
                     content:(NSString *)content
                   timeorder:(NSString *)timeOrder
{
  
    if (_isSuccess == NO) {
        
        [self openDB];
    }
    
    //插入sql语句
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO saveRemind ('year','month','day','hour','minute','title','content','timeorder') VALUES('%d','%d','%d','%d','%d','%@','%@','%@')",year,month,day,hour,minute,title,content,timeOrder];
    
    char *err;
    
    if (sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        
        NSAssert(0, @"插入数据错误");
        
    }
    
    //插入完数据关闭数据库，释放内存
    sqlite3_close(_database);
    _isSuccess = NO;

}

//查询数据库
- (NSArray *)selectAction
{
    if (_isSuccess == NO) {
        
        [self openDB];
    }
    
   NSString *sql = @"select * from saveRemind order by timeorder";
    sqlite3_stmt *statement;

    NSMutableArray *arrForModel = [NSMutableArray array];
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSArray *arr = @[@"year",@"month",@"day",@"hour",@"minute",@"title",@"content"];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int i = 0; i < arr.count; i++) {
                
                char *strForContent = (char *)sqlite3_column_text(statement, i+1);
                NSString *str = [[NSString alloc] initWithUTF8String:strForContent];
                [dic setObject:str forKey:arr[i]];
                
            }
  
            RemindModel *model = [[RemindModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            [arrForModel addObject:model];
            
        }
        
    }
    
    NSArray *arrForAllModel = arrForModel;

    //插入完数据关闭数据库，释放内存
    sqlite3_close(_database);
    _isSuccess = NO;
    
    return arrForAllModel;
}


#pragma mark 创建数据库

//创建路径
- (NSString *)filePath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"saveRemind.sqlite"];
}

//创建新的数据库
- (BOOL)createNewSQL:(sqlite3 *)db
{
    
    char *sql = "create table if not exists saveRemind(ID INTEGER PRIMARY KEY AUTOINCREMENT, year int, month int, day int, hour int, minute int, title text, content text, timeorder varchar)";
    
    sqlite3_stmt *statement;
    //sqlite3_prepare_v2 接口把一条SQL语句解析到statement结构里去. 使用该接口访问数据库是当前比较好的的一种方法
    
    NSInteger sqlReturn = sqlite3_prepare_v2(_database, sql, -1, &statement, nil);
    //第一个参数就是数据库本身， sqlite3 *
    //第二个参数试sql语句
    //第三个参数试sql语句长度，小于0表示自动获取sql语句长度
    //第四个参数是sqlite3_stmt 的指针的指针，解析后的sql语句就放在这个结构里
    //第五个参数试错误信息提示，一般不用，置为nil
    
    if (sqlReturn != SQLITE_OK) {
        
        JYLog(@"解析sql语句的时候出错");
        //return NO;
    }
    
    //执行sql语句
    int success = sqlite3_step(statement);
    
    //释放statement
    sqlite3_finalize(statement);
    
    
    if (success != SQLITE_OK) {
        
        JYLog(@"执行sql语句的时候出错");
        return NO;
    }
    
    
    JYLog(@"解析成功");

    return YES;

}










@end
