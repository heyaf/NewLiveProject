//
//  CalendarModel.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/10/12.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CalendarModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*City;

@property (nonatomic, strong) NSString <Optional>*Significance;

@property (nonatomic, strong) NSString <Optional>*Country;
@property (nonatomic, strong) NSString <Optional>*Event;
@property (nonatomic, strong) NSString <Optional>*CreateDate;
@property (nonatomic, strong) NSString <Optional>*CreateTime;
@property (nonatomic, strong) NSString <Optional>*ID;

//City = "威斯康辛州",
//Significance = "60%",
//Country = "美国",
//Event = "2017年FOMC票委、芝加哥联储主席埃文斯(Charles Evans)就经济和货币政策发表演讲。",
//CreateDate = "20171013",
//CreateTime = "22:25",
//ID = 2318,


@end
