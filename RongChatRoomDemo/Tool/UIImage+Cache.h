//
//  UIImage+Cache.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/30.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Cache)

+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key;
+ (UIImage*)GetImageFromLocal:(NSString*)key;
+(UIImage *)cropImage:(UIImage *)image scale:(CGSize)scale;

+(void)uploadImageWithUrl:(NSString *)strUrl dataParams:(NSMutableDictionary *)dataParams imageParams:(NSMutableDictionary *) imageParams Success:(void(^)(NSDictionary *resultDic)) success Failed:(void(^)(NSError *error))fail;
@end
