//
//  AppDelegate+AppService.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/19.
//  Copyright © 2017年 徐阳. All rights reserved.
//
@class userModel;
#import "AppDelegate.h"
//#import "userModel.h"

#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]
static NSString * const SectionID = @"SectionID";

/**
 包含第三方 和 应用内业务的实现，减轻入口代码压力
 */
@interface AppDelegate (AppService)



//@property (nonatomic,assign) userModel *myuser;
//初始化服务
-(void)initService;

//初始化 window
-(void)initWindow;

//初始化 UMeng
-(void)initUMeng;

//初始化用户系统
-(void)initUserManager;

//监听网络状态
- (void)monitorNetworkStatus;

-(void)startleader;
//单例
+ (AppDelegate *)shareAppDelegate;

-(userModel *)getusermodel;
-(void)userToZero;
-(void)showMessage:(NSString *)title contentStr:(NSString *)content;
/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;
@end
