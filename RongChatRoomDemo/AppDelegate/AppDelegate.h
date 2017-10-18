//
//  AppDelegate.h
//  RongChatRoomDemo
//
//  Created by 杜立召 on 16/4/6.
//  Copyright © 2016年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) NSArray *userList;

@property (strong, nonatomic) MainTabBarController *mainTabBar;

@property (nonatomic,strong) NSString *selfID;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *selfName;


@end

