//
//  CollectionViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/12.
//  Copyright © 2017年 rongcloud. All rights reserved.
//
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


#import "CollectionViewController.h"
#import "LBNavTabbarView.h"
#import "VideoCollectViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
//    imageview.image = [UIImage imageNamed:@"navigationitem"];
//    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW/2-100, 30, 200, 20)];
//    titleLB.text = @"视频";
//    titleLB.font = [UIFont systemFontOfSize:20.0];
//    titleLB.textColor = KWhiteColor;
//    titleLB.textAlignment = NSTextAlignmentCenter;
//    [imageview addSubview:titleLB];
//    [self.view addSubview:imageview];
    NSMutableArray *vcArr = [NSMutableArray array];
    NSArray *titleArr = @[@"新闻",@"视频"];
    
    BaseCellViewController *baseVC = [[BaseCellViewController alloc] init];
    baseVC.navigationItem.title = @"收藏";
    baseVC.sizeH = KScreenH-64-44;
    baseVC.urlString = CollectionNewsList;
    userModel *user = [kApp getusermodel];
    baseVC.parament = @{@"userType":@"1",
                        @"userId":user.Id
                        };
    [self addChildViewController:baseVC];
    [vcArr addObject:baseVC];

    
    
    VideoCollectViewController *vc = [[VideoCollectViewController alloc] init];
    vc.sizeH = KScreenH-64-44;
    [self addChildViewController:vc];
    vc.urlString = CollectionVideoList;
    vc.parentview = self.view;
    
    vc.parament = @{@"userType":@"1",
                    @"userId":user.Id
                    };
    [vcArr addObject:vc];
        

    
    
    LBNavTabbarView * view = [[LBNavTabbarView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 44) andVCArr:vcArr andTitleArr:titleArr lineHeight:2 currentVC:self];
    
    [self.view addSubview:view];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationitem"] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationItem setTitle:@"收藏"];
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@""]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
