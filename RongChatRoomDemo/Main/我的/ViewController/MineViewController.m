//
//  MineViewController.m
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


#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "SDImageCache.h"
#import "IBAlertView.h"
#import "BaseCellViewController.h"
#import "suggestViewController.h"
#import "MBProgressHUD+MJ.h"
#import "OwnerViewController.h"
#import "LoginInViewController.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewController.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UIImageView *headerImageV;
@property (nonatomic,strong) UILabel *nameLB;
@property (nonatomic,strong) UIButton *loginBTN;
@property (nonatomic,strong) UIButton *regietBtn;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.navigationController.navigationBar.tintColor = KWhiteColor;
    [self creatData];
    [self creatUI];
    [self refreshUI];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];


    [self refreshUI];
}
-(void)viewDidAppear:(BOOL)animated{

   
}
-(void)viewWillDisappear:(BOOL)animated{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationitem"] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@""]];

    
}
-(void)creatData{
    _dataArr = [NSMutableArray array];
    
    

    
}


-(void)creatUI{
//    [self.view setBackgroundColor:RGB(242, 242, 242)];

    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 150)];
    headerView.backgroundColor = RGB(85, 85, 85);
    headerView.image = [UIImage imageNamed: @"image_ownbg"];
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    
    UIImageView *picImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    picImv.image = IMAGE_NAMED(@"icon_head");
    picImv.layer.masksToBounds = YES;
    picImv.layer.cornerRadius = 35;
    picImv.layer.shadowRadius=2;
    picImv.layer.shadowColor = KWhiteColor.CGColor;
    picImv.center = headerView.center;
    picImv.userInteractionEnabled = YES;
    [headerView addSubview:picImv];
    _headerImageV = picImv;
    
//    userModel *user = [kApp getusermodel];

    
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW/2-100, picImv.frame.origin.y+80, 200, 20)];
    
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = KWhiteColor;
        [headerView addSubview:label];
        _nameLB =label;
    
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(KScreenW/2-50, picImv.frame.origin.y+80, 45, 20);
        [btn1 setTitle:@"登陆" forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(loginin) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn1];
        _loginBTN = btn1;
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(KScreenW/2+5, picImv.frame.origin.y+80, 45, 20);
        [btn2 setTitle:@"注册" forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(loginin) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn2];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(KScreenW/2-1, picImv.frame.origin.y+83, 2, 15)];
        lineView.backgroundColor = KWhiteColor;
        [headerView addSubview:lineView];
        _regietBtn = btn2;
        _lineView = lineView;
    
    
    
    
    _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 150, KScreenW, 280)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"mineCell"];
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [picImv addGestureRecognizer:tapGesturRecognizer];
    
}
-(void)refreshUI{
    userModel *user = [kApp getusermodel];
    
    if (user.niceName.length>0) {
        _headerImageV.image = [UIImage GetImageFromLocal:kHeaderImageKey];
        _nameLB.hidden = NO;
        _nameLB.text = user.niceName;
        _loginBTN.hidden = YES;
        _lineView.hidden = YES;
        _regietBtn.hidden = YES;
    }else{
        _headerImageV.image = [UIImage imageNamed: @"icon_head"];
        _nameLB.hidden = YES;
        _loginBTN.hidden = NO;
        _lineView.hidden = NO;
        _regietBtn.hidden = NO;
    }
    if (user.picture.length>0) {
     
        [_headerImageV sd_setImageWithURL:[NSURL URLWithString:user.picture] placeholderImage:[UIImage imageNamed: @"icon_head"]];
    }
    
}

#pragma mark    ------登陆注册------
-(void)loginin{

    LoginInViewController *loginVC = [[LoginInViewController alloc] init];
    loginVC.myRegistblock = ^{
        [self refreshUI];
    };
    [self presentViewController:loginVC animated:YES completion:nil];
}




-(void)tapAction:(id)tap
{
    userModel *user = [kApp getusermodel];
    if (user.niceName.length>0) {
        OwnerViewController *ownVC = [[OwnerViewController alloc] init];
        ownVC.navigationItem.title = @"个人中心";
        ownVC.changeblock = ^{
        [self refreshUI];
           
        };
        [self.navigationController pushViewController:ownVC animated:YES];
    }
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }

      return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section==0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGE_NAMED(@"icon_collection");
        cell.textLabel.text = @"我的收藏";
        cell.detailTextLabel.text = @">";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section==1&&indexPath.row==0){
    
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.titleImage.image = IMAGE_NAMED(@"icon_push");
        cell.titleLB.text = @"推送";
        cell.subimv.image = IMAGE_NAMED(@"off");
        return cell;
    }else if(indexPath.section ==1&&indexPath.row==1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGE_NAMED(@"icon_delete");
        cell.textLabel.text = @"清除缓存";
        CGFloat size = [self folderSizeAtPath:[self getCachesPath]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",size];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else if(indexPath.section ==2&&indexPath.row==0){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGE_NAMED(@"icon_suggest");
        cell.textLabel.text = @"意见反馈";
        cell.detailTextLabel.text = @">";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else if(indexPath.section ==2&&indexPath.row==1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGE_NAMED(@"icon_about");
        cell.textLabel.text = @"关于我们";
        cell.detailTextLabel.text = @">";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }


    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 20)];
    view.backgroundColor = RGB(242, 242, 242);
    return view;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
       
        userModel *user = [kApp getusermodel];
        if (user.Id.length<1) {
            [kApp showMessage:@"提示" contentStr:@"请先登陆"];
        }else{
        
            CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
            [self.navigationController pushViewController:collectionVC animated:YES];
        }
        
    }else if (indexPath.section==1&&indexPath.row==0){
        
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.message = @"要打开推送通知，请在【设置-通知-允许通知】进行操作";

        configration.confirmTitle=@"确定";
    
        configration.messageAlignment = NSTextAlignmentCenter;
        
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
 
        }];
        [alerView show];
        
    }else if(indexPath.section ==1&&indexPath.row==1){
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self cleanCaches:[self getCachesPath]];
        
        
    }else if(indexPath.section ==2&&indexPath.row==0){
//        self.navigationController.navigationBarHidden = NO;
        suggestViewController *suggestVC = [[suggestViewController alloc] init];
        [self.navigationController pushViewController:suggestVC animated:YES];
        
    }else if(indexPath.section ==2&&indexPath.row==1){
     RootWebViewController *webVC = [[RootWebViewController alloc] init];
        webVC.url = @"http://www.leaguecc.com:6661/aboutuscontroller/getAboutus";
//        webVC.url = @"http://www.leaguecc.com:6661/index/kLine";
        [self.navigationController pushViewController:webVC animated:YES];

    }

}
// 获取Caches目录路径
- (NSString *)getCachesPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
    NSString *cachesDir = [paths lastObject];
    return cachesDir;
}
- (CGFloat)folderSizeAtPath:(NSString *)path{
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
    // 目录下的文件计算大小
    NSArray *childrenFile = [manager subpathsAtPath:path];
    for (NSString *fileName in childrenFile) {
        NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
        size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
    } //SDWebImage的缓存计算
    size += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    // 将大小转化为M
    return size / 1024.0 / 1024.0;
    }
    return 0;
}
- (void)cleanCaches:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) { // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName]; // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil]; } }
    //SDWebImage的清除功能
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showSuccess:@"清除成功" toView:self.view];
    }];
    [[SDImageCache sharedImageCache] clearMemory]; }
    
    

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
