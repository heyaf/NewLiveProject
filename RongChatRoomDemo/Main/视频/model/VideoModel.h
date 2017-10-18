//
//  VideoModel.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/19.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface VideoModel : JSONModel
/*
 id = 15,
 state = 1,
 videoName = "切格瓦拉",
 url = "http://192.168.0.192:8083/1505788351430.mp4",
 date = 1505788353000,
 */
@property (nonatomic, strong) NSString <Optional>*Id;
@property (nonatomic, strong) NSString <Optional>*state;
@property (nonatomic, strong) NSString <Optional>*videoName;
@property (nonatomic, strong) NSString <Optional>*videourl;
@property (nonatomic, strong) NSString <Optional>*date;
@property (nonatomic, strong) NSString <Optional>*content;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*count;
@property (nonatomic, strong) NSString <Optional>*picture;



@end
