//
//  StringToData.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/10/25.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "StringToData.h"

@implementation StringToData
+(NSString *)StringToDate:(NSString *)str{
    
    
    
    NSTimeInterval timestamp =  str.doubleValue / 1000.0;
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    // 实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 设定时间格式
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    // 转换后的字符串
    NSString *resultStr = [dateFormatter stringFromDate: detaildate];
       
   
    return resultStr;
}


@end
