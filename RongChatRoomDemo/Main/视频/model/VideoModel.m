//
//  VideoModel.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/19.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Id"}];
}

@end
