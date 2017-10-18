//
//  userModel.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/5.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "userModel.h"

@implementation userModel

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Id"}];
}
@end
