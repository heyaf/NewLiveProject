//
//  News1ViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/15.
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


#import "News1ViewController.h"
#import "HomeTableViewCell.h"
#import "LBNavTabbarView.h"


@interface News1ViewController ()


@end

@implementation News1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    NSMutableArray *vcArr = [NSMutableArray array];
    NSArray *titleArr = @[@"要闻",@"时政",@"财经",@"军事"];
    for (int i =0; i<4; i++) {
        BaseCellViewController *vc = [[BaseCellViewController alloc] init];
        vc.sizeH = KScreenH-64-48-44;
        [self addChildViewController:vc];
        vc.urlString = MessageNewsUrl;
        vc.parentview = self.view;
        NSString *catagoryStr = [NSString stringWithFormat:@"%i",i+1];
        vc.parament = @{@"NewscategoryID":catagoryStr};
        [vcArr addObject:vc];
        
    }
    
    
    LBNavTabbarView * view = [[LBNavTabbarView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 44) andVCArr:vcArr andTitleArr:titleArr lineHeight:2 currentVC:self];
    
    [self.view addSubview:view];


    
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
