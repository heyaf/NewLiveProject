//
//  basemodel.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/7.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "basemodel.h"

@implementation basemodel
+(JSONKeyMapper *)keyMapper{
//    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id":@"Id"}];
     return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"Id"}];
}
@end
