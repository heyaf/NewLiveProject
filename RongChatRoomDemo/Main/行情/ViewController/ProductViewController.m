//
//  ProductViewController.m
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


#import "ProductViewController.h"
#import "ProductTableViewCell.h"
#import "productmodel.h"

@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource>{

    dispatch_source_t _timer;
}

@property (nonatomic,strong) UITableView *tabelView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,strong) UIButton *myBttton;
//是涨跌点
@property (nonatomic,assign) BOOL isdiffAmo;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KBlackColor;
    
    _dataArr = [NSArray array];
    _isdiffAmo = YES;
//    [self creatData];
    
    [self creatHeaderView];
    [self creatTableView];
    [self startGCDTimer];
}

-(void)creatData{

//    [MBProgressHUD showMessage:@"正在加载..."];
    [[HttpRequest sharedInstance] getWithURLString:HangqingUrl parameters:nil success:^(id responseObject) {
        [MBProgressHUD hideHUD];

        NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSString *code = dicJson[@"resultcode"];
        if ([code isEqualToString:@"200"]) {
//            NSLog(@"12121......");
            
            NSDictionary *dateDic =dicJson[@"result"][0];
            NSMutableArray *dateArr1 = [NSMutableArray arrayWithCapacity:0];
            for (int i=1; i<dateDic.count+1; i++) {
                NSString *datestr = [NSString stringWithFormat:@"data%i",i];
                
                [dateArr1 addObject:dateDic[datestr]];

            }
           

            _dataArr = [productmodel arrayOfModelsFromDictionaries:dateArr1 error:nil];
            
            if (!_tabelView) {
                [self creatTableView];
            }
            [_tabelView reloadData];
            _isdiffAmo = !_isdiffAmo;
            
        }else{
        
            [MBProgressHUD showError:@"加载失败..."];
            [self refreshUI];
        }
        
        
        
    } failure:^(NSError *error) {

        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败..."];
        [self refreshUI];

    } ];
    
     
}
-(void)startGCDTimer{
    NSTimeInterval period = 30.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
//        NSLog(@"1212121");
        //在这里执行事件
       [self refreshUI];
    });
    
    dispatch_resume(_timer);
}

-(void) pauseTimer{
    if(_timer){
        dispatch_suspend(_timer);
    }
}
-(void) resumeTimer{
    if(_timer){
        dispatch_resume(_timer);
    }
}
-(void) stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
-(void) refreshUI{

    [_myBttton setTitle:@"涨跌点" forState:UIControlStateNormal];
    _isdiffAmo = YES;
//    if (_dataArr.count>0) {
//      
//        [_tabelView reloadData];
//    }else{
    
        [self creatData];
//    }
}


-(void)creatHeaderView{

    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, 30)];
    _headerView.backgroundColor = RGB(35, 43, 55);
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 40, 20)];
    titleLB.text = @"名称";
    titleLB.font = [UIFont systemFontOfSize:14];
    titleLB.textColor = KWhiteColor;
    [_headerView addSubview:titleLB];
    
    UILabel *titleLB1 = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW/2-10, 5, 40, 20)];
    titleLB1.font = [UIFont systemFontOfSize:14];
    titleLB1.text = @"最新";
    titleLB1.textColor = KWhiteColor;
    [_headerView addSubview:titleLB1];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(KScreenW-80, 5, 70, 20);
    [btn setTitle:@"涨跌幅" forState:UIControlStateNormal];
    [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClickedForchange:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFont:[UIFont systemFontOfSize:14]];
    
    _myBttton = btn;
    [_headerView addSubview:btn];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(62, 12, 8, 8)];
    imageview.image = [UIImage imageNamed:@"image_bottom"];
    imageview.userInteractionEnabled = YES;
    [btn addSubview:imageview];
    
    [self.view addSubview:_headerView];
    
}
-(void)btnClickedForchange:(id)sender{
    
    MBProgressHUD * hud1 = [MBProgressHUD showHUDAddedTo: [UIApplication sharedApplication].keyWindow animated:YES];
//    [[[UIApplication sharedApplication].windows lastObject] addSubview:hud1];
    

    if (_isdiffAmo) {
        [_myBttton setTitle:@"涨跌幅" forState:UIControlStateNormal];
        
    }else{
    
        [_myBttton setTitle:@"涨跌点" forState:UIControlStateNormal];

    }
    [self creatData];

    
}

-(void)creatTableView{

    _tabelView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64+30, KScreenW, KScreenH-30-48-64) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.alwaysBounceVertical = NO;
    _tabelView.backgroundColor = KBlackColor;
    [_tabelView registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"productCell"];
    
    [self.view addSubview:_tabelView];
                
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"productCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = RGB(13, 15, 25);
    
    productmodel *model = _dataArr[indexPath.row];
    cell.TitleLB.text = model.currency;
    cell.subtitleLB.text = model.code;
    cell.newsLB.text = model.buyPic;
    if (_isdiffAmo) {
        cell.btnLB.text = model.diffAmo;
    }else{
    
        cell.btnLB.text = model.diffPer;
    }
    
    
    float f = [model.diffAmo floatValue];
    if (f>0) {
        cell.btnLB.backgroundColor = RGB(205, 48, 27);
    }else{
        cell.btnLB.backgroundColor = RGB(27, 179, 120);
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 48;
}

-(void)viewDidDisappear:(BOOL)animated{
    

    [self stopTimer];
}
-(void)viewDidAppear:(BOOL)animated{

   
    [self startGCDTimer];
 
}
-(void)viewWillAppear:(BOOL)animated{


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
