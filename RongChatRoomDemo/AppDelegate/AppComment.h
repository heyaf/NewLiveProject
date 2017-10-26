//
//  AppComment.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/9.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#ifndef AppComment_h
#define AppComment_h

//颜色
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]


#define HHTabSelectedColor RGB(18, 153, 247)

//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"



#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"


/*
 一些navigation的默认颜色和字体
 */

//主题
#define HHNavBgColor  RGB(44,50,59)
#define HHNavBgMoreColor RGB(19, 22, 26)
#define HHNavBgFontColor  [UIColor blueColor]

//默认页面背景色
#define HHViewBgColor [UIColor blueColor]

//分割线颜色
#define HHLineColor [UIColor blueColor]

//次级字色
#define HHFontColor1 [UIColor blueColor]

//再次级字色
#define HHFontColor2 [UIColor blueColor]


#pragma mark -  字体区


#define HHFont1 [UIFont systemFontOfSize:12.0f]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]


#define IMAGE_NAMED(name) [UIImage imageNamed:name]

#endif /* AppComment_h */
