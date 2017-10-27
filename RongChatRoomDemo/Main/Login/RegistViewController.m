//
//  RegistViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/1.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "RegistViewController.h"
#import "XieYiViewController.h"
#import <SMS_SDK/SMSSDK.h>
//#import "ZXTextField.h"


@interface RegistViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *TelText;
@property (nonatomic,strong) UITextField *PassText;
@property (nonatomic,strong) UITextField *codeText;


@property (nonatomic,strong) UIButton *LoginBtn;
@property (nonatomic, strong) UIButton *countdownButton;

@property (nonatomic,assign) BOOL IsHiden;///<是否密文显示密码
@property (nonatomic,strong) UIImageView *eyeimageView; ///<密文显示的图标

//@property (nonatomic,strong)
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _IsHiden = YES;
    [self creatUI];
}
- (UIButton *)countdownButton {
    if (!_countdownButton) {
        _countdownButton = [[UIButton alloc] init];
        _countdownButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countdownButton setTitle:kSendVerifyCode forState:UIControlStateNormal];
        [_countdownButton setTitleColor:RGB(69, 163, 229) forState:UIControlStateNormal];
        _countdownButton.layer.cornerRadius = 5;
        _countdownButton.layer.masksToBounds = YES;
        _countdownButton.layer.borderColor = RGB(69, 163, 229).CGColor;
        _countdownButton.layer.borderWidth = 0.8;
        [_countdownButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countdownButton;
}

-(void)creatUI{

  
    _titleLB.text = _titlestr;
    CGRect accountF = CGRectMake(20, 100, KScreenW-40, 40);
    UITextField *TELText = [[UITextField alloc] initWithFrame:accountF];
    TELText.placeholder = @"请输入手机号";
    TELText.frame = accountF;
    TELText.delegate = self;
    [self.view addSubview:TELText];
    self.TelText = TELText;
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 0, 0)];
    
    lineview.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:lineview];
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(45);
        make.left.mas_equalTo(TELText);
        make.right.mas_equalTo(TELText);
        make.height.offset(1);

    }];
    
    UITextField *textfild1 = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, KScreenW-100, 40) ];
    textfild1.placeholder = @"6～15位密码";
    textfild1.secureTextEntry = YES;
    [self.view addSubview:textfild1];
    self.PassText = textfild1;
    
    [textfild1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(60);
        make.left.mas_equalTo(TELText);
        make.right.mas_equalTo(TELText);
        make.height.offset(40);
    }];
    
    UIButton *hidenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hidenBtn addTarget:self action:@selector(hidenBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hidenBtn];
    
    [hidenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(60);
        make.width.offset(50);
        make.right.mas_equalTo(TELText);
        make.height.offset(40);
    }];
    
    UIImageView *hidenimageview = [[UIImageView alloc] init];
    [self.view addSubview:hidenimageview];
    hidenimageview.image = IMAGE_NAMED(@"icon_eye_close");
    self.eyeimageView = hidenimageview;
    [hidenimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hidenBtn).with.offset(10);
        make.width.offset(30);
        make.right.mas_equalTo(hidenBtn).with.offset(10);
        make.height.offset(20);
    }];
    
    

    UIView *lineview1 = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 0, 0)];
    lineview1.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:lineview1];
    [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild1).with.offset(45);
        make.left.mas_equalTo(textfild1);
        make.right.mas_equalTo(textfild1);
        make.height.offset(1);
        
    }];
    
    UITextField *textfild = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, KScreenW-100, 40) ];
    textfild.placeholder = @"请输入验证码";
    [self.view addSubview:textfild];
    self.codeText = textfild;
    
    [textfild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild1).with.offset(60);
        make.left.mas_equalTo(textfild1);
        make.right.mas_equalTo(textfild1);
        make.height.offset(40);
    }];
    UIView *lineview2 = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 0, 0)];
    lineview2.backgroundColor = RGB(242, 242, 242);
    [self.view addSubview:lineview2];
    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild).with.offset(45);
        make.left.mas_equalTo(textfild);
        make.right.mas_equalTo(textfild);
        make.height.offset(1);
        
    }];
    
    UILabel *hintLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 120, 320, 20)];
    hintLabel.numberOfLines=0;
    hintLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild).with.offset(55);
        make.left.mas_equalTo(textfild);
        make.right.mas_equalTo(textfild);
        make.height.offset(30);
    }];
    
    if ([self.titlestr isEqualToString:@"注册"]) {
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"注册即表示您已同意《中思财经用户服务协议》"];
        //获取要调整颜色的文字位置,调整颜色
        
        
        NSRange range2=[[hintString string]rangeOfString:@"《中思财经用户服务协议》"];
        [hintString addAttribute:NSForegroundColorAttributeName value:RGB(69, 163, 229) range:range2];
        
        hintLabel.attributedText=hintString;
        
        
        UIButton *XieyiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [XieyiBtn addTarget:self action:@selector(XieyiBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:XieyiBtn];
        [XieyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(hintLabel);
            make.left.mas_equalTo(hintLabel);
            make.right.mas_equalTo(hintLabel);
            make.height.mas_equalTo(hintLabel);
            
        }];
        
        
        [self.view addSubview:self.countdownButton];
        [_countdownButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(textfild);
            make.right.mas_equalTo(TELText);
            make.bottom.mas_equalTo(textfild);
            make.width.offset(120);
        }];

    }
       /*
     登录按钮
     */
    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBtn.layer.cornerRadius = 20.0f;
    _LoginBtn.layer.masksToBounds = YES;
    [_LoginBtn setBackgroundColor:RGB(69, 163, 229) ];
    
    [_LoginBtn setTitle:_loginBtntitle forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(makeSureBtn) forControlEvents:UIControlEventTouchUpInside];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
//    _LoginBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15];
    [self.view addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textfild).with.offset(40+20+50);
        make.left.offset(57.5);
        make.right.offset(-57.5);
        make.height.offset(40.0);
    }];

}
-(void)XieyiBtn{

    XieYiViewController *xieyiVC = [[XieYiViewController alloc] init];
    [self presentViewController:xieyiVC animated:YES completion:nil];
    
}

-(void)hidenBtn{
    if (self.IsHiden) {
        self.PassText.secureTextEntry = NO;
        self.eyeimageView.image = IMAGE_NAMED(@"icon_eye_open");
        
    }else{
    
        self.PassText.secureTextEntry = YES;
        self.eyeimageView.image = IMAGE_NAMED(@"icon_eye_close");
    }

    self.IsHiden = !self.IsHiden;


}


- (IBAction)BtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)sendMessage:(UIButton *)button{
    if (self.TelText.text.length<1) {
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.confirmTitle=@"确定";
        
        configration.messageAlignment = NSTextAlignmentCenter;
        configration.message = @"请填写手机号";
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            
        }];
        
        [alerView show];
    }else{

    [button startWithSeconds:60];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_TelText.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            
        }
        else
        {
            
        }
    }];
    }
}

-(void)makeSureBtn{
    
    
    

    if (self.TelText.text.length<1) {
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.confirmTitle=@"确定";
        
        configration.messageAlignment = NSTextAlignmentCenter;
        configration.message = @"请填写手机号";
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            
        }];

        [alerView show];
    }else if (_PassText.text.length<6 || self.PassText.text.length>15){
    
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.confirmTitle=@"确定";
        
        configration.messageAlignment = NSTextAlignmentCenter;
        configration.message = @"密码格式不对，请重新填写";
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            
        }];

        [alerView show];
        
    }else if(self.codeText.text.length<=1){
    
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.confirmTitle=@"确定";
        
        configration.messageAlignment = NSTextAlignmentCenter;
        configration.message = @"验证码不能为空";
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            
        }];

        [alerView show];
    }else{
        [self sendmessage];
    
    }

    
}
//网络请求
-(void)sendmessage{

    NSDictionary *dic = @{@"phoneNumber":self.TelText.text,
                          @"password":_PassText.text,
                          @"code":self.codeText.text};
    [MBProgressHUD showMessage:@"正在加载..."];
    NSString *utf = [self.urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[HttpRequest sharedInstance] postWithURLString:utf parameters:dic success:^(id responseObject) {
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        NSDictionary *dict = responseObject;
        NSString *message = [NSString stringWithFormat:@"%@",dict[@"message"]];
        NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
//        NSLog(@"....%@,%@",dict,message);
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"操作成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
           
            
        }else if ([code isEqualToString:@"2"])
        {
            [MBProgressHUD showError:message];
        }else
        {
            [MBProgressHUD showError:message];
        }
    } failure:^(NSError *error) {
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
//        NSLog(@"错误原因：%@",error.description);

        [MBProgressHUD showError:@"操作失败，请稍后重试"];
    }];
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
