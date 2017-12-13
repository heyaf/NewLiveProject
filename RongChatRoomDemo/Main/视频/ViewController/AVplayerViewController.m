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
//#import "XJAVPlayer.h"
#import "HeaderView.h"
#import "HomeTableViewCell.h"
#import "VideoModel.h"
#import "ZFPlayer.h"

@interface AVplayerViewController ()<ZFPlayerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (strong, nonatomic)  UIView *playerFatherView;

@property (nonatomic,strong)HeaderView *headerView;

@property (nonatomic,strong)UITableView *tableview;
@property(nonatomic, strong) NSArray *dataArr;
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation AVplayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =KWhiteColor;
    self.navigationController.navigationBar.tintColor = KWhiteColor;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];

    
   
    
    //把视频被点击信息传给服务器
    [self sendNumber];
    [self setMoviePlayer];
    [self creatUIWithmodel:self.videomodel];
    [self creatData];
    // 自动播放，默认不自动播放
    [self.playerView autoPlayTheVideo];
}
-(void)setMoviePlayer{
    self.playerFatherView = [[UIView alloc] init];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ISIPHONEX ? 30.f : 0.f);
        make.leading.trailing.mas_equalTo(0);
        // 这里宽高比16：9,可自定义宽高比
        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];

    
}
- (void)zf_playerBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    //    self.backBtn.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.backBtn.alpha = 0;
    }];
}

- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    //    self.backBtn.hidden = fullscreen;
    [UIView animateWithDuration:0.25 animations:^{
        self.backBtn.alpha = !fullscreen;
    }];
}

#pragma mark - Getter

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = @"";
        _playerModel.videoURL         = [NSURL URLWithString:self.videourl];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = self.playerFatherView;
        
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        [_playerView playerControlView:nil playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
        
        // 打开下载功能（默认没有这个功能）
//        _playerView.hasDownload    = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}

-(void)sendNumber{

    NSDictionary *dic = @{@"id":self.videomodel.Id};
    [[HttpRequest sharedInstance] postWithURLString:VideoCollectNum parameters:dic success:^(id responseObject) {
        
        
        NSDictionary *dict = responseObject;
        
        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
        }else{
            
            
        }
    } failure:^(NSError *error) {
        
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        
    }];

    
}

-(void)creatData{
    
    NSDictionary*dic =@{@"pageNumber":@"1",
                        @"pageSize":@"10"
                        };
    [[HttpRequest sharedInstance] postWithURLString:VideoListUrl parameters:dic success:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        NSDictionary *dict = responseObject;
        
        if ([dict[@"state"] isEqualToString:@"0"]) {
            [MBProgressHUD showError:dict[@"msg"]];
        }else{
            _dataArr = [VideoModel arrayOfModelsFromDictionaries:dict[@"videos"] error:nil];
            for (VideoModel *model in _dataArr) {
                model.date = [StringToData StringToDate:model.date];
            }
            if (!_tableview) {
                [self creatTableView];
            }else{
                
                [_tableview reloadData];
            }
            
            
        }
    } failure:^(NSError *error) {
        
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        
    }];
    
}


-(void)creatUIWithmodel:(VideoModel *)myvideomodel{

    
    _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 200, KScreenW, 80) andVideomodel:myvideomodel isselected:YES];
 
    _headerView.select = YES;
    _headerView.ifselected = YES;
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playerFatherView.mas_bottom);
        make.leading.trailing.mas_equalTo(0);
        make.height.equalTo(@80);
    }];
    
}


-(void)creatTableView{

    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, KScreenW, KScreenH-280)];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"homecell"];
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playerFatherView.mas_bottom).offset(80);
        make.leading.trailing.mas_equalTo(0);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; //去掉 bar 下面有一条黑色的线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}
-(void)viewDidAppear:(BOOL)animated{

    
}
-(void)viewWillDisappear:(BOOL)animated{
    
   
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"homecell"];
    VideoModel *videomodel = _dataArr[indexPath.row];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.titleLB.text = videomodel.title;
    cell.numberLB.text = videomodel.count;
    
    cell.dateLB.text = videomodel.date;
    
    [cell.titleImv sd_setImageWithURL:[NSURL URLWithString:videomodel.picture] placeholderImage:IMAGE_NAMED(@"image_zhanwei")];
    
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
    _playerModel.videoURL = [NSURL URLWithString:videomodel.videourl];
    [self.playerView resetToPlayNewVideo:_playerModel];
    [_headerView removeFromSuperview];
    [self creatUIWithmodel:videomodel];
    
}

#pragma mark ----ZFPlayerDelegate-----

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
