//
//  WeatherTool.m
//  JYCalendar
//
//  Created by 吴冬 on 15/10/19.
//  Copyright (c) 2015年 玄机天地. All rights reserved.
//

#import "WeatherTool.h"
#import "JYWeatherModel.h"

static WeatherTool *_weatherTool = nil;

@implementation WeatherTool



+ (WeatherTool *)shareWeatherTool
{
 
    if (_weatherTool == nil) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            _weatherTool = [[WeatherTool alloc] init];
            
        });
    }
    
    return _weatherTool;
    
}

/**
 *  请求天气的方法
 *
 *  @param httpUrl url
 *  @param HttpArg 城市id
 */
- (void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"c08b8c98670ce47bdf851d76057b3eac" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                                   
                               } else {
                                   
                                   //NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   
                                   NSArray *arrForModel = [self returnCityAndWeatherAndTem:result];
                                   
                                   //Block传值
                                   _arrForPassModel(arrForModel);
                                   
                                   //                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   //                                   NSLog(@"HttpResponseBody %@",result);
                               }
                           }];
    

}


- (NSArray *)returnCityAndWeatherAndTem:(id )result
{
    
    
    NSArray *weatherArr = [result objectForKey:@"weather"];
    NSMutableArray *arrForWeather = [NSMutableArray array];
    
    for (int i = 0; i < weatherArr.count; i++) {
        
        //        "18",  //天气图标编号
        //        "雾",  //天气情况
        //        "17",  //温度
        //        "无持续风向",  //风向
        //        "微风"  //风力
        
        JYWeatherModel *model = [[JYWeatherModel alloc] init];
        NSDictionary *weatherArr1 = [weatherArr[i] objectForKey:@"info"];
        
        if (weatherArr1.count == 1) {
            
            
            NSString *cityStr = [[[result objectForKey:@"area"] objectAtIndex:0] objectAtIndex:0];
            model.cityStr = cityStr;
            
            NSArray *nightArr = [weatherArr1 objectForKey:@"night"];
            [self actionForModel:nil nightArr:nightArr andModel:model];
            [arrForWeather addObject:model];
            
        }else if(weatherArr1.count == 2){
            
            NSString *cityStr = [[[result objectForKey:@"area"] objectAtIndex:0] objectAtIndex:0];
            model.cityStr = cityStr;
            
            NSArray *dayArr = [weatherArr1 objectForKey:@"day"];
            NSArray *nightArr = [weatherArr1 objectForKey:@"night"];
            
            [self actionForModel:dayArr nightArr:nightArr andModel:model];
            [arrForWeather addObject:model];
            
        }else{
            
            
            NSString *cityStr = [[[result objectForKey:@"area"] objectAtIndex:0] objectAtIndex:0];
            model.cityStr = cityStr;
            
            NSArray *dayArr = [weatherArr1 objectForKey:@"day"];
            NSArray *nightArr = [weatherArr1 objectForKey:@"night"];
            
            [self actionForModel:dayArr nightArr:nightArr andModel:model];
            [arrForWeather addObject:model];
            
        }
    }

    return arrForWeather;
}

//存储model
- (void)actionForModel:(NSArray *)dayArr
              nightArr:(NSArray *)nightArr
              andModel:(JYWeatherModel *)model

{
    if (nightArr.count > 0) {
        
        model.picIDN = [nightArr[0] intValue];
        model.weatherStrN = nightArr[1];
        model.tempN = nightArr[2];
        model.windStrN = [nightArr lastObject];
        
    }
    
    if (dayArr.count > 0) {
        
        model.picIDD = [dayArr[0] intValue];
        model.weatherStrD = dayArr[1];
        model.tempD = dayArr[2];
        model.windStrD = [dayArr lastObject];
        
    }
    
    
    
}


@end
