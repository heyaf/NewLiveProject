//
//  AppDelegate+AppService.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/19.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "OpenUDID.h"
#import "LoginInViewController.h"
#import "LaunchIntroductionView.h"
#import "DWTabBarController.h"

@implementation AppDelegate (AppService)


#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];    
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];
//    [[UIButton appearance] setShowsTouchWhenHighlighted:YES];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = KWhiteColor;
    
    
    self.mainTabBar = [MainTabBarController new];
    self.window.rootViewController = [[DWTabBarController alloc] init];;
    [self isChecking];
    
    
    userModel *usermodel = [self getusermodel];
    NSString *sectionID = [[NSUserDefaults standardUserDefaults] objectForKey:SectionID];

    if (sectionID.length<=0||usermodel.Id.length<=0) {
        
        [self presentLoginVC];
    }else{
        ASLog(@"通过SECTION登录%@",sectionID);
        //通过Section登录
        NSDictionary *dic =@{@"uuid":sectionID};
        [[HttpRequest sharedInstance] postWithURLString:SectionLoginUrl parameters:dic success:^(id responseObject) {
            
            NSDictionary *dict = responseObject;
            NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
            
            ASLog(@"登陆页%@",dict);
            if ([code isEqualToString:@"1"]) {
                
                
                
                [self saveuserinfoWithdic:dict[@"user"]];

                
                
//                NSLog(@"----个人信息-%@",[kApp getusermodel]);
            }else{
                [self presentLoginVC];
            
            }
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"出错了，请重试"];
            
            
        }];

    
    }
    
}

#pragma mark -判断是否是苹果审核状态
-(void)isChecking{

    

        [[HttpRequest sharedInstance] getWithURLString:iOSCheckUrl parameters:nil success:^(id responseObject) {
        
        NSString *dict = [[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([dict isEqualToString:@"1"]) {
//            kApp.isCheck =YES;
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

-(userModel *)getusermodel{

    // 从本地（@"weather" 文件中）获取.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weather"];
    // data.
    NSData *data = [NSData dataWithContentsOfFile:file];
    // 反归档.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 获取@"model" 所对应的数据
    userModel *usermodel = [unarchiver decodeObjectForKey:kUserinfoKey];
    // 反归档结束.
    [unarchiver finishDecoding];
    return usermodel;
}
-(void)userToZero{

    userModel *usermodel = [[userModel alloc] init];
    usermodel.Id = nil;
    usermodel.niceName = nil;
    usermodel.phone = nil;
    usermodel.state = nil;
    usermodel.loginDate = nil;
    usermodel.picture = nil;
    usermodel.password = nil;
    usermodel.createTime = nil;
       
    //    property (nonatomic, strong) NSString <Optional>*identity;
    //    @property (nonatomic, strong) NSString <Optional>*phone;
    //    @property (nonatomic, strong) NSString <Optional>*state;
    //    @property (nonatomic, strong) NSString <Optional>*loginDate;
    //    @property (nonatomic, strong) NSString <Optional>*wechat;
    //    @property (nonatomic, strong) NSString <Optional>*picture;
    //    @property (nonatomic, strong) NSString <Optional>*password;
    //    @property (nonatomic, strong) NSString <Optional>*signature;
    //    @property (nonatomic, strong) NSString <Optional>*createTime;
    //    @property (nonatomic, strong) NSString <Optional>*alterDate;
    //    @property (nonatomic, strong) NSString <Optional>*qq;
    //    @property (nonatomic, strong) NSString <Optional>*email;
    //    @property (nonatomic, strong) NSString <Optional>*name;
    //    @property (nonatomic, strong) NSString <Optional>*certification;
    //    [kUserDefaults setObject:usermodel forKey:kUserinfoKey];
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:usermodel forKey:kUserinfoKey];
    // 归档结束.
    [archiver finishEncoding];
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weather"];
    [data writeToFile:file atomically:YES];

    
}
         -(void)saveuserinfoWithdic:(NSDictionary *)dic{
             
             
             
             userModel *usermodel = [[userModel alloc] init];
             usermodel.Id = dic[@"id"];
             usermodel.niceName = dic[@"niceName"];
             usermodel.phone = dic[@"phone"];
             usermodel.state = dic[@"state"];
             usermodel.loginDate = dic[@"loginDate"];
             usermodel.picture = dic[@"picture"];
             usermodel.password = dic[@"password"];
             usermodel.createTime = dic[@"createTime"];
             
             //    [kUserDefaults setObject:usermodel forKey:kUserinfoKey];
             // 创建归档时所需的data 对象.
             NSMutableData *data = [NSMutableData data];
             // 归档类.
             NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
             // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
             [archiver encodeObject:usermodel forKey:kUserinfoKey];
             // 归档结束.
             [archiver finishEncoding];
             // 写入本地（@"weather" 是写入的文件名）.
             NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weather"];
             [data writeToFile:file atomically:YES];
             
         }


//显示提示框
-(void)showMessage:(NSString *)title contentStr:(NSString *)content{

    IBConfigration *configration = [[IBConfigration alloc] init];
    configration.title = title;
    configration.message = content;
    //                    configration.cancelTitle = @"确定";
    configration.confirmTitle=@"确定";
    
    configration.messageAlignment = NSTextAlignmentCenter;
    
    IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
        
    }];
    [alerView show];
}

#pragma mark ------引导页————————————
-(void)startleader{

    [LaunchIntroductionView sharedWithImages:@[@"lead1",@"lead2",@"lead3"] buttonImage:@"" buttonFrame:CGRectMake(kScreen_width/2 - 50, kScreen_height - 100, 100, 45)];
    
}

#pragma mark ———— 登陆界面 ————
-(void) presentLoginVC{

    [kRootViewController presentViewController:[[LoginInViewController alloc] init] animated:YES completion:nil];
}



#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    
    
    
////    DLog(@"设备IMEI ：%@",[OpenUDID value]);
//    if([userManager loadUserInfo]){
//        
//        //如果有本地数据，先展示TabBar 随后异步自动登录
//        self.mainTabBar = [MainTabBarController new];
//        self.window.rootViewController = self.mainTabBar;
//        
//        //自动登录
//        [userManager autoLoginToServer:^(BOOL success, NSString *des) {
//            if (success) {
////                DLog(@"自动登录成功");
//                //                    [MBProgressHUD showSuccessMessage:@"自动登录成功"];
//                KPostNotification(KNotificationAutoLoginSuccess, nil);
//            }else{
//                [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
//            }
//        }];
//        
//    }else{
//        //没有登录过，展示登录页面
//        KPostNotification(KNotificationLoginStateChange, @NO)
////        [MBProgressHUD showErrorMessage:@"需要登录"];
//    }
}

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {//登陆成功加载主窗口控制器
        
//        //为避免自动登录成功刷新tabbar
    }else {//登陆失败加载登陆页面控制器
    }
}


#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
//    BOOL isNetWork = [notification.object boolValue];
//    
//    if (isNetWork) {//有网络
//        if ([userManager loadUserInfo] && !isLogin) {//有用户数据 并且 未登录成功 重新来一次自动登录
//            [userManager autoLoginToServer:^(BOOL success, NSString *des) {
//                if (success) {
//                    DLog(@"网络改变后，自动登录成功");
////                    [MBProgressHUD showSuccessMessage:@"网络改变后，自动登录成功"];
//                    KPostNotification(KNotificationAutoLoginSuccess, nil);
//                }else{
//                    [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
//                }
//            }];
//        }
//        
//    }else {//登陆失败加载登陆页面控制器
//        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
//    }
}


#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
//    /* 打开调试日志 */
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    /* 设置友盟appkey */
//    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
//    
//    [self configUSharePlatforms];
}
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
//    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kSecret_Wechat redirectURL:nil];
//    /*
//     * 移除相应平台的分享，如微信收藏
//     */
//    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
//    
//    /* 设置分享到QQ互联的appID
//     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
}

#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
//}
//
//#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
//    // 网络状态改变一次, networkStatusWithBlock就会响应一次
//    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
//        
//        switch (networkStatus) {
//                // 未知网络
//            case PPNetworkStatusUnknown:
//                DLog(@"网络环境：未知网络");
//                // 无网络
//            case PPNetworkStatusNotReachable:
//                DLog(@"网络环境：无网络");
//                KPostNotification(KNotificationNetWorkStateChange, @NO);
//                break;
//                // 手机网络
//            case PPNetworkStatusReachableViaWWAN:
//                DLog(@"网络环境：手机自带网络");
//                // 无线网络
//            case PPNetworkStatusReachableViaWiFi:
//                DLog(@"网络环境：WiFi");
//                KPostNotification(KNotificationNetWorkStateChange, @YES);
//                break;
//        }
//        
//    }];
//    
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


@end
