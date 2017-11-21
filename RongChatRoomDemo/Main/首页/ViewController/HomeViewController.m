//
//  HomeViewController.m
//  RongChatRoomDemo
//
//  Created by 你大爷 on 2017/8/9.
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


#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "CenterView.h"
#import "CellHeaderView.h"
#import "HomeTableViewCell.h"
#import "LLSearchViewController.h"
//#import <IJKMediaFramework/IJKMediaFramework.h>

//轮播图高度
#define LunboH 149

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *lunboTitleArr;
@property (nonatomic,strong) NSMutableArray *lunboImgArr;
@property (nonatomic,strong) NSMutableArray *lunboUrlArr;

@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor =RGB(220, 220, 220);
    _imageArr = [NSArray arrayWithObjects:@"banner",@"Logbg",@"logo", nil];
    self.navigationController.navigationBar.tintColor = KWhiteColor;
    self.navigationItem.title = @"中思财经";

    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"homecell"];
    [self creatLunboData];
    [self creatHotData];
    [self setcenterView];
    [self creatRightbutton];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    

}


#pragma mark ---------设置右上角搜索按钮-----

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
#pragma mark ---------设置轮播图-----------
-(void)creatHeadScrollView{
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, KScreenW, LunboH) imageNamesGroup:_lunboImgArr];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.currentPageDotColor = RGB(69, 163, 229);
    cycleScrollView.pageDotColor = KWhiteColor;
    cycleScrollView.titlesGroup =_lunboTitleArr;
    cycleScrollView.delegate = self;
    [self.view addSubview:cycleScrollView];
    
}
#pragma mark    -----轮播图回调-----
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{

    RootWebViewController *rootwebVC = [[RootWebViewController alloc] init];
    rootwebVC.url = [NSString stringWithFormat:DetailnewsHTML,_lunboUrlArr[index]];
    //    NSLog(@"*******%@",basemodel);
    rootwebVC.messageID = _lunboUrlArr[index];
    
    
    rootwebVC.saveMessage = YES;
    [self.navigationController pushViewController:rootwebVC animated:YES];


}
#pragma mark ---------设置center中心图------
-(void)isChecking{
    
    
    
    [[HttpRequest sharedInstance] getWithURLString:iOSCheckUrl parameters:nil success:^(id responseObject) {
        
        NSString *dict = [[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        if ([dict isEqualToString:@"1"]) {
            kApp.isCheck =YES;
        }
        [self setcenterView];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


-(void)setcenterView{
    
    NSArray *imageArr;
    NSArray *titleArr;
    if (kApp.isCheck) {
    
    imageArr = @[@"icon_analyst",@"icon_news",@"icon_fast",@"icon_calender"];
    titleArr = @[@"分析",@"要闻",@"快讯",@"日历"];
    }else{
    
        imageArr = @[@"icon_analyst",@"icon_contest",@"icon_news",@"icon_fast",@"icon_calender"];
        titleArr = @[@"分析",@"竞赛",@"要闻",@"快讯",@"日历"];
    
    }
    
    CenterView *cenview = [[CenterView alloc] initWithFrame:CGRectMake(0, 64+LunboH, KScreenW, 96.5) imageArr:imageArr andtitle:titleArr];
    [self.view addSubview:cenview];
    
}
#pragma mark ------设置tableview-------
-(void)creatTableview{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LunboH+96.5+15+64, KScreenW, KScreenH-(LunboH+96.5+15+64)-48) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    
    [self.view addSubview:_tableView];
    _tableView.separatorColor = RGB(153, 153, 153);
//    _tableView.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
                                                              
}

#pragma mark ---------网络请求-------
-(void)creatLunboData{

    _lunboImgArr = [NSMutableArray array];
    _lunboTitleArr = [NSMutableArray array];
    _lunboUrlArr = [NSMutableArray array];
    [MBProgressHUD showMessage:@"正在加载..."];
    [[HttpRequest sharedInstance] getWithURLString:LunboUrl parameters:nil success:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        ASLog(@"轮播图......%@",dict);
        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
        }else{
            NSArray *array = dict[@"news"];
            for (NSDictionary *ddic in array) {
                [_lunboUrlArr addObject:[NSString stringWithFormat:@"%@",ddic[@"id"]]];
                [_lunboTitleArr addObject:ddic[@"title"]];
                NSString *picStr =[ddic[@"picture"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
                [_lunboImgArr addObject:picStr];
            }
            
            [self creatHeadScrollView];
            
        }

    } failure:^(NSError *error) {
//        NSLog(@"轮播图......%@",error.description);
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        
    }];

}
-(void)creatHotData{

//    [MBProgressHUD showMessage:@"正在加载中..."];
//    MBProgressHUD *HUB = [MBProgressHUD showMessage:@"正在加载..."]
    NSDictionary *parmar = @{@"pageNumber":@"1",
                             @"pageSize":@"10"};
    [[HttpRequest sharedInstance] postWithURLString:MessageHotNewsUrl parameters:parmar success:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];

        [MBProgressHUD hideHUD];
        ASLog(@"热点数据请求成功");
        NSDictionary *dict = responseObject;
        
        if ([dict[@"state"] isEqualToString:@"0"]) {
             [MBProgressHUD showError:dict[@"msg"]];
        }else{
            _dataArr = [basemodel arrayOfModelsFromDictionaries:dict[@"news"] error:nil];
            for (basemodel *model in _dataArr) {
                model.createTime = [StringToData StringToDate:model.createTime];
            }
            if (!_tableView) {
                [self creatTableview];
            }else{
            
                [_tableView reloadData];
            }

            
        }
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        
    }];

    
}






-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homecell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil] lastObject];
    }
                                                                                                    
    basemodel *basemodel = self.dataArr[indexPath.row];
    cell.titleLB.text = basemodel.title;
    cell.numberLB.text = [NSString stringWithFormat:@"%@浏览",basemodel.newsCount];
    cell.dateLB.text = basemodel.createTime;
    NSString *imgstr =  [basemodel.picture stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    
    [cell.titleImv sd_setImageWithURL:[NSURL URLWithString:imgstr]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   
    basemodel *basemodel = self.dataArr[indexPath.row];
    
    RootWebViewController *rootwebVC = [[RootWebViewController alloc] init];
    rootwebVC.url = [NSString stringWithFormat:DetailnewsHTML,basemodel.Id];
    //    NSLog(@"*******%@",basemodel);
    rootwebVC.messageID = basemodel.Id;
    
    
    rootwebVC.saveMessage = YES;
    [self.navigationController pushViewController:rootwebVC animated:YES];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    CellHeaderView *headerview = [[CellHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 40.5)];
    return headerview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40.5;
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
