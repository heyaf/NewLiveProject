//
//  VideoViewController.m
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


#import "VideoViewController.h"
#import "VideoCollectionViewCell.h"
#import <RongIMLib/RongIMLib.h>
#import "RCDLiveChatRoomViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "RCDLiveKitCommonDefine.h"
#import "RCDLive.h"
#import "AVplayerViewController.h"
#import "VideoModel.h"
#import "MJRefresh.h"


@interface VideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{

    NSString *watchUrl;
    NSString *titleStr;
    NSString *chatRoomId;
    NSString *contentStr;
    NSString *liveTime;
    NSString *headPicUrl;
    NSString *companyId;
    NSString *countNum;

}
@property (nonatomic,strong) UICollectionView *collectionview;
/*!
 屏幕方向
 */
@property(nonatomic, assign) BOOL isScreenVertical;
@property(nonatomic, strong) NSArray *dataArr;


@property(nonatomic,strong) UILabel *numberLB; ///<数量按钮

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    imageview.image = [UIImage imageNamed:@"navigationitem"];
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW/2-100, 30, 200, 20)];
    
    titleLB.text = @"视频";
    titleLB.font = [UIFont systemFontOfSize:20.0];
    titleLB.textColor = KWhiteColor;
    titleLB.textAlignment = NSTextAlignmentCenter;
    [imageview addSubview:titleLB];
    [self.view addSubview:imageview];

    [self creatLiveListDate];
    [self creatData];
//    [self creatHeaderView];

}
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationitem"] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationItem setTitle:@"视频"];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@""]];
}

-(void)creatData{

    [MBProgressHUD showMessage:@"正在加载..."];
    
 //直播列表
//    [[HttpRequest sharedInstance] postWithURLString:LiveListUrl parameters:nil success:^(id responseObject) {
//        [MBProgressHUD hideHUD];
//        
//        NSDictionary *dict = responseObject;
//        
//        if ([dict[@"state"] isEqualToString:@"0"]) {
//            [MBProgressHUD showError:dict[@"msg"]];
//        }else{
//            _dataArr = [VideoModel arrayOfModelsFromDictionaries:dict[@"videos"] error:nil];
//            
//            if (!_collectionview) {
//                [self CreatCollectionView];
//            }else{
//                
//                [_collectionview reloadData];
//            }
//            
//            
//        }
//    } failure:^(NSError *error) {
//        
//        [MBProgressHUD hideHUD];
//        
//        
//    }];

    //往期视频列表
    NSDictionary*dic =@{@"pageNumber":@"1",
                        @"pageSize":@"10"
                        };
    [[HttpRequest sharedInstance] postWithURLString:VideoListUrl parameters:dic success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        
        NSDictionary *dict = responseObject;
        NSLog(@"视频界面----------%@",dict);


        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
        }else{
            _dataArr = [VideoModel arrayOfModelsFromDictionaries:dict[@"videos"] error:nil];
            
            if (!_collectionview) {
                [self CreatCollectionView];
            }else{
                
                [_collectionview reloadData];
            }
            
            
        }
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载错误..."];
        NSLog(@"视频界面----------%@,%@,%@",error.description,VideoListUrl,dic);
        
        
        
    }];

}
-(void)creatLiveListDate{

    [MBProgressHUD showMessage:@"正在加载..."];
    [[HttpRequest sharedInstance] getWithURLString:LiveListUrl parameters:nil success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"直播列表数据..__________________________.%@",dict);
        
         [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        if ([dict[@"state"] isEqualToString:@"0"]) {
            UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, 250)];
            [self.view addSubview:headerview];
            UIImageView *liveimV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 210)];
            liveimV.image = IMAGE_NAMED(@"Playnostart");
            liveimV.userInteractionEnabled = YES;
            [headerview addSubview:liveimV];
        }else{
            watchUrl = dict[@"liveContents"][0][@"watchUrl"];
            titleStr = dict[@"liveContents"][0][@"title"];
            liveTime = dict[@"liveContents"][0][@"liveTime"];
            chatRoomId = dict[@"liveContents"][0][@"chatroomId"];
            contentStr = dict[@"liveContents"][0][@"content"];
            companyId = dict[@"liveContents"][0][@"companyID"];
            NSDictionary *ditt = @{@"id":dict[@"liveContents"][0][@"id"]};
            [[HttpRequest sharedInstance] postWithURLString:LivePicUrl parameters:ditt success:^(id responseObject) {
                [MBProgressHUD hideHUD];
                
                NSDictionary *mydict = responseObject;
                
                if ([mydict[@"state"] isEqualToString:@"1"]) {
                    headPicUrl = mydict[@"pictureUrl"];
                }
                [self creatHeaderView];
                [self creatNumberLBContent];

            } failure:^(NSError *error) {
                
                [MBProgressHUD hideHUD];
                
                
            }];


            
        }
        
    } failure:^(NSError *error) {
         [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    }];
}
-(void)creatNumberLBContent{
    
    NSDictionary*dic =@{@"companyId":companyId,
                        
                        };

    [[HttpRequest sharedInstance] postWithURLString:LiveGetNumberUrl parameters:dic success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        
        NSDictionary *mydict = responseObject;
        
        
        
            _numberLB.text = [NSString stringWithFormat:@"%@人观看",mydict[@"onlineNumber"]];
            countNum = [NSString stringWithFormat:@"%@",mydict[@"onlineNumber"]];
        
        ASLog(@"直播观看人数%@",mydict);
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
        
        
    }];
    

}

-(void)creatHeaderView{

    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, 250)];
//    headerview.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:headerview];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [headerview addGestureRecognizer:tapGesturRecognizer];
    
    UIImageView *liveimV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 210)];
    if (headPicUrl.length>0) {
        [liveimV sd_setImageWithURL:[NSURL URLWithString:headPicUrl]];
    }else{
    
       liveimV.image = IMAGE_NAMED(@"aaa");
    }
    
    liveimV.userInteractionEnabled = YES;
    [headerview addSubview:liveimV];
    
    UIImageView *tagimV = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW-100, 0, 100, 25)];
    tagimV.image = IMAGE_NAMED(@"live");
    [headerview addSubview:tagimV];
    
    UIImageView *shapeimV = [[UIImageView alloc] initWithFrame:CGRectMake(0, liveimV.frame.size.height-30, KScreenW, 30)];
    shapeimV.image = IMAGE_NAMED(@"video_shadow");
    [liveimV addSubview:shapeimV];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, KScreenW-150, 20)];
    titleLB.font = [UIFont systemFontOfSize:15.0];
    titleLB.text = titleStr;
    titleLB.textColor = KWhiteColor;
    [shapeimV addSubview:titleLB];
    
    UILabel *nameLB = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW-140, 8, 140, 20)];
    nameLB.text = @"主讲人：张老师";
    nameLB.font = [UIFont systemFontOfSize:15.0];
    nameLB.textColor = KWhiteColor;
    [shapeimV addSubview:nameLB];
    
    UILabel *dataLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 215, 200, 20)];
    dataLB.text = [NSString stringWithFormat:@"%@",liveTime];
    dataLB.textColor = RGB(153, 153, 153);
    dataLB.font = [UIFont systemFontOfSize:12.0];
    dataLB = _numberLB;
    [headerview addSubview:dataLB];
    
    UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW-100, 215, 100, 20)];
    numberLB.text = @"198人观看";
    numberLB.textColor = RGB(153, 153, 153);
    numberLB.font = [UIFont systemFontOfSize:12];
    numberLB.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:numberLB];
}
-(void)tapAction:(id)tap

{
    
    
//    [self enterChatRoom];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"Token"];
    NSString *Name = [userDefaults stringForKey:@"Name"];
    NSString *selfID = [userDefaults stringForKey:@"selfID"];
    AppDelegate *delegate =kApp;

    if (token.length>0) {
        delegate.token=token;
        delegate.selfName=Name;
        delegate.selfID=selfID;
        
        
        [self enterChatRoom];
    }else{
        userModel *usermodel = [kApp getusermodel];
        
        NSString *appID = [NSString stringWithFormat:@"%@%i",[self getNowDate],[self getRandomNumber:1 to:1000]];
        if (usermodel.Id.length < 1) {

            [self RCIMgetTokenWithName:@"游客" AndID:appID];
        }else{
            
        [self RCIMgetTokenWithName:usermodel.niceName AndID:appID];
        }
    }

    
}
-(void)RCIMgetTokenWithName:(NSString *)username AndID:(NSString *)userID{
    
    NSString *userId = userID;
    NSString *userName = username;
    NSString *userProtrait = @"www";
    
    userId = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    
    //    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    //    int x = arc4random() % 6;
    
    NSDictionary *params = @{@"userId":userId, @"name":userName, @"protraitUrl":userProtrait};;
    
    
    
    NSString *url = @"http://api.cn.ronghub.com/user/getToken.json";
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    
    NSString *nonce = [NSString stringWithFormat:@"%d", rand()];
    
    long timestamp = (long)[[NSDate date] timeIntervalSince1970];
    
    NSString *unionString = [NSString stringWithFormat:@"%@%@%ld", RONGCLOUD_IM_APPSECRET, nonce, timestamp];
    const char *cstr = [unionString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:unionString.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    mgr.requestSerializer.HTTPShouldHandleCookies = YES;
    
    NSString *timestampStr = [NSString stringWithFormat:@"%ld", timestamp];
    
    [mgr.requestSerializer setValue:RONGCLOUD_IM_APPKEY forHTTPHeaderField:@"App-Key"];
    [mgr.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [mgr.requestSerializer setValue:timestampStr forHTTPHeaderField:@"Timestamp"];
    [mgr.requestSerializer setValue:output forHTTPHeaderField:@"Signature"];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    __weak __typeof(&*self)weakSelf = self;
    
    [mgr POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObj) {
        
        NSNumber *code = responseObj[@"code"];
        if (code.intValue == 200) {
            NSString *token = responseObj[@"token"];
            NSString *IuserId = responseObj[@"userId"];
            
            
            AppDelegate *delegate =kApp;
            delegate.token=token;
            delegate.selfID=IuserId;
            delegate.selfName=userName;
            [weakSelf enterChatRoom];
            //            [_hub hideAnimated:YES];
            
            //存储数据
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:token forKey:@"Token"];
            [userDefaults setObject:userName forKey:@"Name"];
            [userDefaults setObject:IuserId forKey:@"selfID"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        _hub.label.text=@"登陆失败，请稍后重试";
        //        [_hub hideAnimated:YES afterDelay:2.0];
    }];
}


-(void)CreatCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个item的大小，
    CGFloat W = (KScreenW-10)/2;
    flowLayout.itemSize = CGSizeMake(W, W/10*6+50);
    //
//    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    // 设置列的最小间距
    flowLayout.minimumInteritemSpacing = 10;
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 0;
    // 设置布局的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 250+64, KScreenW, KScreenH-250-64-48) collectionViewLayout:flowLayout];
    _collectionview.backgroundColor = KWhiteColor;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    [_collectionview registerNib:[UINib nibWithNibName:@"VideoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"VideoCELL"];

    _collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.collectionview.mj_header beginRefreshing];
//        [self creatDatawithpage:1 andaddData:NO];
    }];
    self.collectionview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.collectionview.mj_footer beginRefreshing];
//        [self creatDatawithpage:_page+1 andaddData:YES];
        
    }];

    

    [self.view addSubview:_collectionview];
}
// 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
// 每个分区多少个item
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCELL" forIndexPath:indexPath];

    VideoModel *videomodel = _dataArr[indexPath.row];
    
    cell.titleLB.text = videomodel.videoName;
    
    cell.dataLB.text = videomodel.date;
    NSString *imgstr =  [videomodel.picture stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    [cell.titleImv sd_setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:IMAGE_NAMED(@"image_zhanwei")];

    return cell;
}


// 点击图片的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel *videomodel = _dataArr[indexPath.row];

    AVplayerViewController *avplayerVC = [[AVplayerViewController alloc] init];
    

    if (videomodel.videourl.length>0) {
        avplayerVC.videourl = videomodel.videourl;
        avplayerVC.videomodel = videomodel;
        [self.navigationController pushViewController:avplayerVC animated:YES];
    }


    
}


-(void)getData{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://1.192.218.167:6660/liveStream/getPageUrl?id=6" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"....%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"失败.......%@",[error description]);
    }];
    
}
-(void)enterChatRoom{
    AppDelegate *delegate =kApp;
    NSString *token =delegate.token;
//    [RCDLive sharedRCDLive] con
    [[RCDLive sharedRCDLive] connectRongCloudWithToken:token success:^(NSString *loginUserId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RCUserInfo *user = [[RCUserInfo alloc]init];
            user.userId = delegate.selfID;
            user.portraitUri = @"rtmp://live.hkstv.hk.lxdns.com/live/hks";
            user.name = delegate.selfName;
            [RCIMClient sharedRCIMClient].currentUserInfo = user;
            RCDLiveChatRoomViewController *chatRoomVC = [[RCDLiveChatRoomViewController alloc]init];
            chatRoomVC.conversationType = ConversationType_CHATROOM;
            chatRoomVC.targetId = chatRoomId;
            chatRoomVC.contentURL = watchUrl;
            chatRoomVC.isScreenVertical = _isScreenVertical;
            
            
            VideoModel *videomodel = [[VideoModel alloc] init];
            videomodel.title = titleStr;
            videomodel.content = contentStr;
            videomodel.count = countNum;
            chatRoomVC.videomodel = videomodel;
            
            
            [self.navigationController pushViewController:chatRoomVC animated:NO];
            
        });
    } error:^(RCConnectErrorCode status) {
        dispatch_async(dispatch_get_main_queue(), ^{

            [kApp showMessage:@"提示" contentStr:@"获取信息失败，请稍后重试"];

           
        });
        
    } tokenIncorrect:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            userModel *usermodel = [kApp getusermodel];
            
            NSString *appID = [NSString stringWithFormat:@"%@%i",[self getNowDate],[self getRandomNumber:1 to:1000]];
            if (usermodel.Id.length < 1) {
                
                [self RCIMgetTokenWithName:@"游客" AndID:appID];
            }else{
                
                [self RCIMgetTokenWithName:usermodel.niceName AndID:appID];
            }

        });
    }];
    
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark -----获取当前日期和随机数------
-(NSString *)getNowDate{
    
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    NSString *nowDate = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld",comp.year,comp.month,comp.day,comp.hour,comp.minute,comp.second];
    
    return nowDate;
    
}
-(int)getRandomNumber:(int)from to:(int)to

{
    
    return (int)(from + (arc4random() % (to-from + 1)));
    
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
