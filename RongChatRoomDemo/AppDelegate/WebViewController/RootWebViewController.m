//
//  RootWebViewController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "RootWebViewController.h"
#import <WebKit/WebKit.h>

@interface RootWebViewController ()<WKNavigationDelegate,WKUIDelegate>
{
    WKUserContentController * userContentController;
}
@property(nonatomic, strong) WKWebView *wkwebView;
@property (strong, nonatomic) UIProgressView *progressView;//这个是加载页面的进度条
@property (nonatomic,strong) MBProgressHUD *hud;

@property (nonatomic,strong) UIButton*rightButton;
@property (nonatomic,assign) BOOL collect;
@end

@implementation RootWebViewController

-(instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
        _progressViewColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    
    [self initWKWebView];
    if (self.saveMessage) {
        [self sendNumber];
    }
    _hud = [MBProgressHUD showHUDAddedTo: [UIApplication sharedApplication].keyWindow animated:YES];
    [[[UIApplication sharedApplication].windows lastObject] addSubview:_hud];
    //    NSLog(@"0....0%@",self.url);
    _hud.labelText = NSLocalizedString(@"请稍候...", @"HUD loading title");

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    userModel *user = [kApp getusermodel];
    if (user.Id.length > 0 && _messageID.length>0) {
       
        [self getmessageWithUrl:ChargeCollection];
    }
    [self initProgressView];
    NSLog(@"WEbyeURl%@",self.url);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
}

-(void)sendNumber{
    
    NSDictionary *dic = @{@"newsId":self.messageID};
    [[HttpRequest sharedInstance] postWithURLString:NewsCollectNum parameters:dic success:^(id responseObject) {
        
        
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
//网络请求
-(void)sendmessageWithUrl:(NSString *)url {
    

    userModel *user = [kApp getusermodel];
    if (user.Id.length < 1) {
        [kApp showMessage:@"提示" contentStr:@"请先登录"];
    }else{
          NSDictionary *dict =@{@"userType":@"1",
                                @"userId":user.Id,
                                @"newsId":_messageID
                                };
          NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        MBProgressHUD * hud1 = [MBProgressHUD showHUDAddedTo: [UIApplication sharedApplication].keyWindow animated:YES];
        [[[UIApplication sharedApplication].windows lastObject] addSubview:hud1];
        //    NSLog(@"0....0%@",self.url);
        hud1.labelText = NSLocalizedString(@"请稍候...", @"HUD loading title");
          [[HttpRequest sharedInstance] postWithURLString:utf parameters:dict success:^(id responseObject) {
               [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
              [MBProgressHUD hideHUD];
              NSDictionary *dict = responseObject;
              
              NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
        
        
             
              if ([code isEqualToString:@"1"]) {
           
                  [MBProgressHUD showSuccess:@"操作成功"];
    
                  if ([url isEqualToString:Collectionnews]) {
                       //收藏成功
                      _collect = YES;
                      [_rightButton setImage:[UIImage imageNamed:@"icon_collection_selected"] forState:UIControlStateNormal];
                  }else{
                  //取消收藏成功
                      [_rightButton setImage:[UIImage imageNamed:@"icon_collection_defaul"] forState:UIControlStateNormal];
                      
                      _collect = NO;
                  }
                  
                
              }else  {
                  NSString *message = [NSString stringWithFormat:@"%@",dict[@"msg"]];
            
                  [MBProgressHUD showError:message];
              }
          } failure:^(NSError *error) {
               [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        
              [MBProgressHUD hideHUD];
              [MBProgressHUD showError:@"操作失败，请稍后重试"];
          }];
          }
}
-(void)getmessageWithUrl:(NSString *)url {
    
    
    userModel *user = [kApp getusermodel];
    
    NSDictionary *dic =@{@"userType":@"1",
                         @"userId":user.Id,
                         @"newsId":_messageID
                          };
    NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[HttpRequest sharedInstance] postWithURLString:utf parameters:dic success:^(id responseObject) {
//         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        NSDictionary *dict = responseObject;
        NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
        
        
        if ([code isEqualToString:@"1"]) {
            _collect = YES;
            [_rightButton setImage:[UIImage imageNamed:@"icon_collection_selected"] forState:UIControlStateNormal];
            
        }else if ([code isEqualToString:@"0"])
        {
            _collect = NO;
             [_rightButton setImage:[UIImage imageNamed:@"icon_collection_defaul"] forState:UIControlStateNormal];
        }
    } failure:^(NSError *error) {
//         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [MBProgressHUD showError:@"操作失败，请稍后重试"];
    }];
}





#pragma mark 初始化webview
-(void)initWKWebView
{
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];//先实例化配置类 以前UIWebView的属性有的放到了这里
    //注册供js调用的方法
    userContentController =[[WKUserContentController alloc]init];
//    //弹出登录
//    [userContentController addScriptMessageHandler:self  name:@"loginVC"];
//    
//    //加载首页
//    [userContentController addScriptMessageHandler:self name:@"gotoFirstVC"];
//    
//    //进入详情页
//    [userContentController addScriptMessageHandler:self  name:@"gotodetailVC"];
    
    configuration.userContentController = userContentController;
    configuration.preferences.javaScriptEnabled = YES;//打开js交互
    if (self.RectH>0) {
        
    }
    _wkwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _RectH, KScreenW, KScreenH) configuration:configuration];
    [self.view addSubview:_wkwebView];
    _wkwebView.backgroundColor = [UIColor clearColor];
    _wkwebView.allowsBackForwardNavigationGestures =YES;//打开网页间的 滑动返回
    _wkwebView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
//    if ([UIDevice systemVersion]>=9) {
//        _wkwebView.allowsLinkPreview = YES;//允许预览链接
//    }
    _wkwebView.UIDelegate = self;
    _wkwebView.navigationDelegate = self;
    [_wkwebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];//注册observer 拿到加载进度
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_wkwebView loadRequest:request];
    
    
}

#pragma mark --这个就是设置的上面的那个加载的进度
-(void)initProgressView
{
    CGFloat progressBarHeight = 30.0f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    //        CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight-0.5, navigaitonBarBounds.size.width, progressBarHeight);
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height, navigaitonBarBounds.size.width, progressBarHeight);
    if (!_progressView || !_progressView.superview) {
        _progressView =[[UIProgressView alloc]initWithFrame:barFrame];
        _progressView.tintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
        
        [self.navigationController.navigationBar addSubview:self.progressView];
    }
}
//检测进度条，显示完成之后，进度条就隐藏了
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (object == self.wkwebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        [self.progressView setProgress:newprogress animated:YES];

//        [self.progressView setProgress:newprogress animated:YES];
        if (newprogress == 1) {
            [_hud hide:YES afterDelay:0.1];
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}


#pragma mark - ——————— WKNavigationDelegate ————————
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
// 当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.title = webView.title;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
}
// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

#pragma mark - update nav items

-(void)updateNavigationItems{
    if (self.saveMessage) {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
        
        if (_collect) {
            [_rightButton setImage:[UIImage imageNamed:@"icon_collection_selected"] forState:UIControlStateNormal];
//            [self sendmessageWithUrl:UnCollectionnews];
        }else{
            
            [_rightButton setImage:[UIImage imageNamed:@"icon_collection_defaul"] forState:UIControlStateNormal];
//            [self sendmessageWithUrl:Collectionnews];
        }

        
        [_rightButton addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
        
        self.navigationItem.rightBarButtonItem= rightItem;

    }
}
-(void)shareBtn{
    if (_collect) {
        [self sendmessageWithUrl:UnCollectionnews];
    }else{
    
       
        [self sendmessageWithUrl:Collectionnews];
    }

    
}

-(void)leftBtnClick:(UIButton *)btn{
    switch (btn.tag) {
        case 2000:
            [self.wkwebView goBack];
            break;
        case 2001:
            [self backBtnClicked];
            break;
        default:
            break;
    }
}

-(void)reloadWebView{
    [self.wkwebView reload];
}
-(void)dealloc{
    [self clean];
}
#pragma mark ————— 清理 —————
-(void)clean{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.wkwebView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.wkwebView.UIDelegate = nil;
    self.wkwebView.navigationDelegate = nil;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
