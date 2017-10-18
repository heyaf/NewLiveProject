//
//  AppManager.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/21.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "AppManager.h"
#import "AdPageView.h"
#import "RootWebViewController.h"

#import "RootNavigationController.h"
//#import "YYFPSLabel.h"

@implementation AppManager


+(void)appStart{
    //加载广告
    AdPageView *adView = [[AdPageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) withTapBlock:^{
        RootNavigationController *loginNavi =[[RootNavigationController alloc] initWithRootViewController:[[RootWebViewController alloc] initWithUrl:@"https://www.hao123.com"]];
        [kRootViewController presentViewController:loginNavi animated:YES completion:nil];
//        NSLog(@"AAAAA");
    }];
    adView = adView;
}
#pragma mark ————— FPS 监测 —————
+(void)showFPS{
//    YYFPSLabel *_fpsLabel = [YYFPSLabel new];
//    [_fpsLabel sizeToFit];
//    _fpsLabel.bottom = KScreenHeight - 55;
//    _fpsLabel.right = KScreenWidth - 10;
//    //    _fpsLabel.alpha = 0;
//    [kAppWindow addSubview:_fpsLabel];
}

@end
