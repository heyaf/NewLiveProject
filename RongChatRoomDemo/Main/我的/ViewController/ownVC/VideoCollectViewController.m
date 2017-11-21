//
//  VideoCollectViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/10/7.
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


#import "VideoCollectViewController.h"
#import "HomeTableViewCell.h"
#import "MJRefresh.h"
#import "VideoModel.h"
#import "AVplayerViewController.h"



@interface VideoCollectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *MydataArr;


@property (nonatomic,assign) NSInteger page;
@end

@implementation VideoCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.MydataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"homecell"];
    
    //    [self creatTableview];
    _page=1;
    [self creatDatawithpage:1 andaddData:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationitem"] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationItem setTitle:@"视频"];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@""]];

    [self.navigationController.navigationItem setHidesBackButton:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated{

    [self.navigationController.navigationItem setHidesBackButton:YES];
}

#pragma merk ------网络请求数据-------
-(void)creatDatawithpage:(NSInteger) pagenumber andaddData:(BOOL) adddata{
    
//    [MBProgressHUD showMessage:@"正在加载..."];
    
    NSString *pagenum = [NSString stringWithFormat:@"%li",pagenumber];
    
    NSDictionary *paramete1 =@{@"pageNumber":pagenum,
                               @"pageSize":@"20"
                               };
    NSMutableDictionary *paramete =[NSMutableDictionary dictionaryWithDictionary:paramete1];
    if (self.parament.count>0) {
        [paramete addEntriesFromDictionary:self.parament];
    }
    
    
    //    NSLog(@"0.0.0.0%@1212121%@",paramete,self.urlString);
    [[HttpRequest sharedInstance] postWithURLString:self.urlString parameters:paramete success:^(id responseObject) {
        
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        
        //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = responseObject;
//        NSLog(@"0.0.0.0.0.%@",dict);
        
        
        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
            
            
        }else{
            
            NSMutableArray *dataArr = dict[@"videos"];
            if (dataArr.count==0) {
                [MBProgressHUD showSuccess:@"暂无数据"];
            }else{
                
                NSMutableArray *modelarr = [VideoModel arrayOfModelsFromDictionaries:dataArr error:nil];
                for (VideoModel *model in modelarr) {
                    model.date = [StringToData StringToDate:model.date];
                }
                if (!adddata) {
                    [self.MydataArr removeAllObjects];
                }
                [self.MydataArr addObjectsFromArray:modelarr];
                
                if (_tableView) {
                    [_tableView reloadData];
                    
                }else{
                    [self creatTableview];
                }
                
                if (!adddata) {
                    _page=1;
                }else{
                    _page++;
                }
                
            }
            
            
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    //     [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}
#pragma mark ------设置tableview-------
-(void)creatTableview{
    
    CGFloat H;
    CGRect frame;
    if (self.sizeH>0) {
        H = self.sizeH;
        frame = CGRectMake(0, 0, KScreenW, H);
    }else{
        
        H = KScreenH-64-48;
        frame = CGRectMake(0, 100, KScreenW, H);
    }
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    
    [self.view addSubview:_tableView];
    _tableView.separatorColor = RGB(153, 153, 153);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self.tableView.mj_header beginRefreshing];
        [self creatDatawithpage:1 andaddData:NO];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_footer beginRefreshing];
        [self creatDatawithpage:_page+1 andaddData:YES];
        
    }];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homecell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil] lastObject];
    }
    
    
    VideoModel *videomodel = self.MydataArr[indexPath.row];
    cell.titleLB.text = videomodel.title;
    cell.numberLB.text = [NSString stringWithFormat:@"%@观看",videomodel.count];
    cell.dateLB.text = videomodel.date;
    NSString *imgstr =  [videomodel.picture stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    [cell.titleImv sd_setImageWithURL:[NSURL URLWithString:imgstr]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    VideoModel *videomodel = self.MydataArr[indexPath.row];
    
    AVplayerViewController *avplayerVC = [[AVplayerViewController alloc] init];
    avplayerVC.RemoveBackBtn = YES;
    
    
    
    if (videomodel.videourl.length>0) {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIButton alloc] init]];
        self.navigationItem.leftBarButtonItem = colseItem;
        
        avplayerVC.videourl = videomodel.videourl;
        avplayerVC.videomodel = videomodel;
        [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
        [self.navigationController pushViewController:avplayerVC animated:YES];
    }

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.MydataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
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
