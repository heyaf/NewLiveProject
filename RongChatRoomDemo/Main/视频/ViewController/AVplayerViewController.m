//
//  AVplayerViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/2.
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


#import "AVplayerViewController.h"
#import "XJAVPlayer.h"
#import "HeaderView.h"
#import "HomeTableViewCell.h"
#import "VideoModel.h"

@interface AVplayerViewController ()<XJAVPlayerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)XJAVPlayer *myPlayer;

@property (nonatomic,strong)HeaderView *headerView;

@property (nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong) NSArray *dataArr;

@end

@implementation AVplayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =KWhiteColor;
    self.navigationController.navigationBar.tintColor = KWhiteColor;
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
//    self.navigationItem.backBarButtonItem = item;
    
    _myPlayer = [[XJAVPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    if (self.RemoveBackBtn) {
        _myPlayer.hasback=NO;
    }else{
    
        _myPlayer.hasback = YES;
    }
    _myPlayer.delegate = self;
    //
    _myPlayer.xjPlayerUrl = self.videourl;
    //    myPlayer.xjPlayerUrl = [[NSBundle mainBundle] pathForResource:@"Swift.mp4" ofType:nil];
    
    [self.view addSubview:_myPlayer];//(看自动缩小就把它注释了)
    [self creatUI];
    [self creatData];
//    [self creatTableView];
    [self.view bringSubviewToFront:_myPlayer];
    
    
    //把视频被点击信息传给服务器
    [self sendNumber];
}
-(void)sendNumber{

    NSDictionary *dic = @{@"id":self.videomodel.Id};
    [[HttpRequest sharedInstance] postWithURLString:VideoCollectNum parameters:dic success:^(id responseObject) {
        
        
        NSDictionary *dict = responseObject;
        NSLog(@"......121212121%@",dict);
        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
        }else{
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"......121212121%@",error.description);
        [MBProgressHUD hideHUD];
        
        
    }];

    
}

-(void)creatData{
    
    [MBProgressHUD showMessage:@"正在加载..."];
    NSDictionary*dic =@{@"pageNumber":@"1",
                        @"pageSize":@"10"
                        };
    [[HttpRequest sharedInstance] postWithURLString:VideoListUrl parameters:dic success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        
        NSDictionary *dict = responseObject;
        
        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
        }else{
            _dataArr = [VideoModel arrayOfModelsFromDictionaries:dict[@"videos"] error:nil];
            
            if (!_tableview) {
                [self creatTableView];
            }else{
                
                [_tableview reloadData];
            }
            
            
        }
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        
        
    }];
    
}


-(void)creatUI{

    
    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 200, KScreenW, 80) andVideomodel:self.videomodel isselected:YES];
 
    _headerView.select = YES;
    _headerView.ifselected = YES;
    [self.view addSubview:_headerView];
    
}


-(void)creatTableView{

    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, KScreenW, KScreenH-280)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"homecell"];
    [self.view addSubview:_tableview];
    
}

-(void)viewWillAppear:(BOOL)animated{
//    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}
-(void)viewDidAppear:(BOOL)animated{

    if (_myPlayer) {
        [_myPlayer play];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [_myPlayer mypause];
    
    
}

#pragma mark - xjAVPlayer代理
- (void)nextXJPlayer{
//    myPlayer.xjPlayerUrl = @"http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4";
}

- (void)xjPlayerFullOrSmall:(BOOL)flag{
    
    //如果xjPlayer的界面有导航栏或者有tabbar,在全屏代理方法里全屏时进行如下隐藏；
    if (flag) {
//        self.navigationController.navigationBarHidden = YES;
//        self.tabBarController.tabBar.hidden = YES;
        _myPlayer.BBtn.hidden = YES;
        _tableview.hidden  = YES;
    }else{
//        self.navigationController.navigationBarHidden = NO;
//        self.tabBarController.tabBar.hidden = NO;
        _myPlayer.BBtn.hidden = NO;
        _tableview.hidden = NO;
    }
    
    if (flag) {
        /**
         *  全屏时隐藏顶部状态栏。由于iOS7.0后，如果你的plist文件已经设置View controller-based status bar appearance，value设为NO，就不用写下面的代码（我已经封装好）,如果没设置，就把下面的代码放开，就能在全屏时隐藏头部状态栏；
         */
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }else{
        //        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homecell"];
    VideoModel *videomodel = _dataArr[indexPath.row];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.titleLB.text = videomodel.videoName;
    cell.numberLB.text = videomodel.count;
    cell.dateLB.text = videomodel.createDate;
    NSString *imgstr = [NSString stringWithFormat:@"image_0%li",(long)indexPath.row+1];
    
    cell.titleImv.image =[UIImage imageNamed:imgstr];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, KScreenW-40, 40)];
    label.backgroundColor =KWhiteColor;
    label.text = @"    相关视频";
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    VideoModel *videomodel = _dataArr[indexPath.row];

    AVplayerViewController *plaervc = [[AVplayerViewController alloc] init];
    plaervc.videourl =videomodel.videourl;
    plaervc.videomodel = videomodel;
    [self.navigationController pushViewController:plaervc animated:YES];
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
