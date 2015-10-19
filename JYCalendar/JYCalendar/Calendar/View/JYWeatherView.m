//
//  JYWeatherView.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/13.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "JYWeatherView.h"
#import "WeatherTool.h"
#import "JYWeatherModel.h"

@implementation JYWeatherView


//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
        
        
        
        _solarCalendar = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60,50)];
        _solarCalendar.backgroundColor = [UIColor orangeColor];
        _solarCalendar.text = @"2";
        _solarCalendar.font = [UIFont boldSystemFontOfSize:40];
        _solarCalendar.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_solarCalendar];
        
        
        _lunarCalendar = [[UILabel alloc] initWithFrame:CGRectMake(_solarCalendar.right + 5, 5, 100, 25)];
        _lunarCalendar.backgroundColor = [UIColor cyanColor];
        _lunarCalendar.text = @"八月初九";
        _lunarCalendar.font = [UIFont systemFontOfSize:16];
        _lunarCalendar.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lunarCalendar];
        
        
        _weekDay = [[UILabel alloc] initWithFrame:CGRectMake(_solarCalendar.right + 5, _lunarCalendar.bottom , 100, 25)];
        _weekDay.backgroundColor = [UIColor orangeColor];
        _weekDay.text = @"周三";
        _weekDay.font = [UIFont systemFontOfSize:15];
        _weekDay.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_weekDay];
        
        
        _holiDay = [[UILabel alloc] initWithFrame:CGRectMake(5, _solarCalendar.bottom + 5, kScreenWidth - 150, 20)];
        _holiDay.backgroundColor = [UIColor orangeColor];
        _holiDay.text = @"赚钱节";
        _holiDay.font = [UIFont boldSystemFontOfSize:10];
        _holiDay.numberOfLines = 0;
        _holiDay.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_holiDay];
        
        
        _pointDay = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 100 / 2.0, 0, 100, 40)];
        _pointDay.backgroundColor = [UIColor orangeColor];
        _pointDay.text = @"春分";
        _pointDay.font = [UIFont boldSystemFontOfSize:20];
        _pointDay.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pointDay];
        
        
        _imageForWeather = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 50 - 40 - 5 - 5, 5, 50, 50)];
        _imageForWeather.backgroundColor = [UIColor orangeColor];
        [self addSubview:_imageForWeather];
        
        _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageForWeather.origin.x, _imageForWeather.bottom + 2, 50, 20)];
        _cityLabel.text = @"北京市";
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.font = [UIFont boldSystemFontOfSize:13];
        _cityLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_cityLabel];
        
        _temperatureLabel = [[UILabel alloc ] initWithFrame:CGRectMake(_imageForWeather.right + 5, 5, 40, 30)];
        _temperatureLabel.text = @"20°C";
        _temperatureLabel.textAlignment = NSTextAlignmentCenter;
        _temperatureLabel.font = [UIFont boldSystemFontOfSize:13];
        _temperatureLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_temperatureLabel];
        
        
        _weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageForWeather.right, _temperatureLabel.bottom, 50, 20)];
        _weatherLabel.text = @"微风";
        _weatherLabel.textAlignment = NSTextAlignmentCenter;
        _weatherLabel.font = [UIFont boldSystemFontOfSize:13];
        _weatherLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_weatherLabel];
        
        
        _windLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageForWeather.right, _weatherLabel.bottom, 50, 20)];
        _windLabel.text = @"00:00";
        _windLabel.textAlignment = NSTextAlignmentCenter;
        _windLabel.font = [UIFont boldSystemFontOfSize:13];
        _windLabel.backgroundColor = [UIColor orangeColor];
        [self addSubview:_windLabel];
        
        WeatherTool *weatherT = [WeatherTool shareWeatherTool];
        
        [weatherT request:@"http://apis.baidu.com/3023/weather/weather" withHttpArg:@"id=101010300"];
        
        [weatherT setArrForPassModel:^void(NSArray *arrForModel){
            
            _arrForWeather = arrForModel;
            [self createWeatherView:arrForModel andDay:0];
            
        }];
        
        
    }

    return self;

}

- (void)createWeatherView:(NSArray *)arrForModel
                   andDay:(int )day
{

    if (day == nowDay) {
        
        [self actionForWeather:day andArr:arrForModel];
        
    }else if(day == nextDay1){
    
        [self actionForWeather:day andArr:arrForModel];

    
    }else if(day == nextDay2){
    
        [self actionForWeather:day andArr:arrForModel];

    }else if(day == nextDay3){
    
        [self actionForWeather:day andArr:arrForModel];

    }else if(day == nextDay4){
        
        [self actionForWeather:day andArr:arrForModel];

    }else if(day == nextDay5){
       
        [self actionForWeather:day andArr:arrForModel];
        
    }else if(day == nextDay6){
        
        [self actionForWeather:day andArr:arrForModel];

    }
    
    
   
 
}

- (void)actionForWeather:(int )day andArr:(NSArray *)arrForModel
{
  
    JYWeatherModel *model = arrForModel[day];
    
    NSString *strForUrl = [NSString stringWithFormat:@"http://8.su.bdimg.com/icon/weather/aladdin/jpg/a%d.jpg",model.picIDD];
    
    NSURL *url = [NSURL URLWithString:strForUrl];
    
    [_imageForWeather sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
    }];
    
    _weatherLabel.text = model.weatherStrD;
    NSString *temStr = [NSString stringWithFormat:@"%@°C",model.tempD];
    _temperatureLabel.text = temStr;
    _cityLabel.text = [NSString stringWithFormat:@"%@市",model.cityStr];
    _windLabel.text = model.windStrD;

}

@end
