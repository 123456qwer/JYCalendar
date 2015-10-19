//
//  JYDatePicker.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/16.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYDatePicker.h"

@implementation JYDatePicker

- (id)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        

        self.delegate = self;
        self.dataSource = self;
        
        
    }

    return self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 5;
    
}//————返回一个数字，表示UIPickerView显示有多少列

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
      //年
    if (component == 0) {
        
        return 2000;
        
        
      //月
    }else if(component == 1){
       
        return 12;
        
      //日
    }else if(component == 2){
    
        if (_month == 1 || _month == 3 || _month == 5 || _month == 7 || _month == 8 || _month == 10 || _month == 12) {
            
            return 31;
            
        }else if(_month == 2 && _year % 4 != 0){
          
            return 28;
            
        }else if(_year % 4 == 0 && _month == 2){
        
            return 29;
        
        }else{
        
            //[self reloadComponent:2];
            return 30;
        }
        
        
      //时
    }else if(component == 3){
    
        return 24;
    
        
      //分
    }else{
    
        
        return 60;
        
        
    }
    

    
}//————返回数字，表示每一列显示的行数。


//选中的行数
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
    
        _year = 2015 + row + 1;
        //_yearBlock(_year);
        [self reloadComponent:2];
        
    }else if(component == 1){
    
        _month = row + 1;
        //_monthBlock(_month);
        [self reloadComponent:2];

    
    }else if(component == 2){
    
        _day = row + 1;
        //_dayBlock(_day);
    
    }else if(component == 3){
    
        _hour = row + 1;
        //_hourBlock(_hour);
        
    }else{
        
        _minute = row + 1;
        //_minuteBlock(_minute);
        
    }
    
    
}


//返回datePicker的高度
- (CGFloat )pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    
    return 32;
}

//创建datePicker里的内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *labelForTitle = [self actionForCreateTitle:component andRow:row + 1];
 
    return labelForTitle;

}

- (UILabel *)actionForCreateTitle:(NSInteger )component andRow:(NSInteger )row
{
    UILabel *labelforTitle;
    CGFloat widthForLabel = kScreenWidth / 5.0;
    if (component == 0) {
        
        labelforTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 5.0, 32)];
        labelforTitle.text = [NSString stringWithFormat:@"%ld年",2014 + row ];
        labelforTitle.textAlignment = NSTextAlignmentCenter;

        return labelforTitle;

    }else if(component == 1){
    
        labelforTitle = [[UILabel alloc] initWithFrame:CGRectMake(widthForLabel, 0, kScreenWidth / 5.0, 32)];
        labelforTitle.text = [NSString stringWithFormat:@"%ld月",row ];
        labelforTitle.textAlignment = NSTextAlignmentCenter;

        return labelforTitle;

        
    }else if(component == 2){
    
        labelforTitle = [[UILabel alloc] initWithFrame:CGRectMake(widthForLabel * 2, 0, kScreenWidth / 5.0, 32)];
        labelforTitle.text = [NSString stringWithFormat:@"%ld日",row];
        labelforTitle.textAlignment = NSTextAlignmentCenter;

        return labelforTitle;

        
    }else if(component == 3){
    
        labelforTitle = [[UILabel alloc] initWithFrame:CGRectMake(widthForLabel * 3, 0, kScreenWidth / 5.0, 32)];
        labelforTitle.text = [NSString stringWithFormat:@"%ld时",row];
        labelforTitle.textAlignment = NSTextAlignmentCenter;

        return labelforTitle;

        
    }else{
    
        labelforTitle = [[UILabel alloc] initWithFrame:CGRectMake(widthForLabel * 4, 0, kScreenWidth / 5.0, 32)];
        labelforTitle.text = [NSString stringWithFormat:@"%ld分",row];
        
        return labelforTitle;

    }
    
}

@end
