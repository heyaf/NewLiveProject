//
//  News2ViewController.m
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


#import "News2ViewController.h"
#import "News2TableViewCell.h"
#import "News2HeaderView.h"
#import "CalendarModel.h"
#import "DAYCalendarView.h"


@interface News2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) News2HeaderView *newsView;
@property (nonatomic,strong) DAYCalendarView *calendarView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) NSString *dataStr;

@end

@implementation News2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"News2TableViewCell" bundle:nil] forCellReuseIdentifier:@"news2cell"];
    [self creatRightbutton];
    [self creatDataWithData:[self getNowDate]];
}

-(void)creatDataWithData:(NSString *)dataStr{


    [MBProgressHUD showMessage:@"正在加载..."];
    NSDictionary *dic = @{@"datetime":dataStr};
    [[HttpRequest sharedInstance] postWithURLString:CancleDate parameters:dic success:^(id responseObject) {
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        NSDictionary *dict = responseObject;
        NSLog(@"11111%@",dict);
        
        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
        }else{
            _dataArr = [CalendarModel arrayOfModelsFromDictionaries:dict[@"events"] error:nil];
            _dataArr=(NSMutableArray *)[[_dataArr reverseObjectEnumerator] allObjects];

            _dataStr = dataStr;
           
            if (!_tableView) {
                [self creatTableView];
            }else{
            
                [_tableView reloadData];
            }
            
           
            
            
        }
    } failure:^(NSError *error) {
        
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        
    }];

}
-(void)creatRightbutton{
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
    
    [rightButton setImage:[UIImage imageNamed:@"calendar_icon"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(calendarBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem= rightItem;
    
    
    
}
-(void)calendarBtn{

    _bgView.hidden = !_bgView.hidden;

}


-(void)creatTableView{

    CGFloat H;
    if (self.kHeight>0) {
        H = self.kHeight;
    }else{
    
        H = KScreenH-64;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW,H) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 100, KScreenW-40, (KScreenW-40)*.8)];
    view.backgroundColor =KWhiteColor;
    [self.view addSubview:view];
    _calendarView = [[DAYCalendarView alloc] initWithFrame:CGRectMake(0, 0, KScreenW-40, (KScreenW-40)*.8)];
    [view addSubview:_calendarView];
    _bgView = view;
    view.hidden = YES;
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    
    
}
- (void)calendarViewDidChange:(id)sender {
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYYMMdd";
    NSString *dateStr = [formatter stringFromDate:self.calendarView.selectedDate];
    _bgView.hidden = YES;
    
    [self creatDataWithData:dateStr];
}


#pragma mark   -------tableviewdelegate--------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    _newsView = [[News2HeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30) andTitle:_dataStr];
    _newsView.backgroundColor = RGB(242, 242, 242);
    return _newsView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    News2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"news2cell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"News2TableViewCell" owner:self options:nil] lastObject];
    }
    
    CalendarModel *basem = _dataArr[indexPath.row];
    NSString *countryUrl = [NSString stringWithFormat:CountryPicUrl,[basem.Country stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"......%@",countryUrl);
    [cell.countryImv sd_setImageWithURL:[NSURL URLWithString:countryUrl]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleImageV.image = IMAGE_NAMED(@"1");
    cell.titleLable .text = basem.CreateTime;
    cell.contentLable.numberOfLines = 0;
    cell.backgroundColor = RGB(242, 242, 242);
    cell.contentLable.text = basem.Event;
    

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)getNowDate{

    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    NSString *nowDate = [NSString stringWithFormat:@"%ld%ld%ld",comp.year,comp.month,comp.day];

    return nowDate;

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
