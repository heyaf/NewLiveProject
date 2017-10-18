//
//  NewsViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/9.
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


#import "NewsViewController.h"
#import "News1ViewController.h"
#import "News2ViewController.h"
#import "LLSearchViewController.h"

@interface NewsViewController ()
@property (strong, nonatomic)  UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic,strong) News1ViewController *news1VC;
//@property (nonatomic,strong) News2ViewController *news2VC;
@property (nonatomic,strong) RootWebViewController *rootwebVC;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _news1VC = [[News1ViewController alloc] init];
    _news1VC.view.frame = CGRectMake(0, 64, KScreenW, KScreenH-64);
    [self addChildViewController:_news1VC];
    
    _rootwebVC = [[RootWebViewController alloc] init];

    _rootwebVC.RectH = 64;
    _rootwebVC.url = MessageFastNewsUrl;
    [self addChildViewController:_rootwebVC];
   
    [self.view addSubview:_news1VC.view];
    
    [self creatSegementController];
    [self segmentAction:_segmentedControl];
    [self creatRightbutton];
    
}

-(void)creatSegementController{

    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"资讯",@"快讯"]];
    _segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    self.navigationItem.titleView = self.segmentedControl;
//    self.navigationController.navigationBar.barTintColor = KWhiteColor;
    
//    self.segmentedControl.segmentedControlStyle= UISegmentedControlStyleBar;
    self.segmentedControl.tintColor = KWhiteColor;
    self.segmentedControl.layer.masksToBounds = YES;
    self.segmentedControl.layer.cornerRadius = 15;
    self.segmentedControl.selectedSegmentIndex = 0;
    //设置普通状态下(未选中)状态下的文字颜色和字体
    [self.segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [self.segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateSelected]; //添加监听
    [self.segmentedControl setBackgroundColor:KBlackColor];
    
    
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

    
}

-(void)creatRightbutton{
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
    
    [rightButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(searchViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem= rightItem;
    
}

-(void)searchViewController{
        
    LLSearchViewController *seachVC = [[LLSearchViewController alloc] init];
    [self.navigationController pushViewController:seachVC animated:YES];

}



    
- (void)segmentAction:(UISegmentedControl *)click{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self replaceFromOldViewController:_rootwebVC toNewViewController:_news1VC];
    }else
    {
        [self replaceFromOldViewController:_news1VC toNewViewController:_rootwebVC];

    }
    
}

- (void)replaceFromOldViewController:(UIViewController *)oldVc toNewViewController:(UIViewController *)newVc{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController    当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options              动画效果(渐变,从下往上等等,具体查看API)UIViewAnimationOptionTransitionCrossDissolve
     *  animations            转换过程中得动画
     *  completion            转换完成
     */
    [self addChildViewController:newVc];
    [self transitionFromViewController:oldVc toViewController:newVc duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVc didMoveToParentViewController:self];
            [oldVc willMoveToParentViewController:nil];
            [oldVc removeFromParentViewController];
            self.currentVC = newVc;
        }else{
            self.currentVC = oldVc;
        }
    }];
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
