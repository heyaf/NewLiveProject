//
//  CompareViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/22.
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


#import "CompareViewController.h"
#import "CompareTableViewCell.h"

@interface CompareViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *NameArr;
@property (nonatomic,strong) NSArray *NumberChargeArr; ///<交易手数

@property (nonatomic,strong) NSArray *AllGetInArr;  ///<总收益率
@property (nonatomic,strong) NSArray *SomegetInArr; ///<浮动收益率


@end

@implementation CompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"CompareTableViewCell" bundle:nil] forCellReuseIdentifier:@"comparecell"];
    _NameArr = @[@"何老师",@"火枪手2017",@"张小白不白",@"张老师"];
    self.NumberChargeArr = @[@"12138",@"9527",@"5491",@"1956"];
    self.AllGetInArr = @[@"245%",@"210%",@"163%",@"139%"];
    self.SomegetInArr = @[@"158.0%",@"222.0%",@"128.2%",@"285.0%"];
    [self creatTableview];
    
    
}
#pragma mark ------设置tableview-------
-(void)creatTableview{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource= self;
    
    [self.view addSubview:_tableView];
    _tableView.separatorColor = RGB(153, 153, 153);
    //    _tableView.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CompareTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"comparecell"];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CompareTableViewCell" owner:self options:nil] lastObject];
    }
    NSString *imageStr = [NSString string];
    
    switch (indexPath.row) {
        case 0:
            imageStr = @"icon_gold";
            break;
        case 1:
            imageStr = @"icon_Ag";
            break;
        case 2:
            imageStr = @"icon_Cu";
            break;
        
  
        default:
            imageStr = @"icon_Fe";
            break;
    }
    cell.titleImageview.image = IMAGE_NAMED(imageStr);
    if (indexPath.row>=3) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, 26, 26)];///<排名数字
        label.textColor = KWhiteColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%li",(long)(indexPath.row+1)];
        [cell.titleImageview addSubview:label];
    }
    cell.NameLable.text = self.NameArr[indexPath.row];
    cell.shouyilvLB.text = self.AllGetInArr[indexPath.row];
    cell.numberLB.text = self.NumberChargeArr[indexPath.row];
    cell.fushouyiLB.text = self.SomegetInArr[indexPath.row];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 68;
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
