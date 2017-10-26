//
//  LoginInViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/8.
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


#import "LoginInViewController.h"
#import "ZXTextField.h"
#import <Masonry.h>
#import "RegistViewController.h"

@interface LoginInViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) ZXTextField *TelText;
@property (nonatomic,strong) ZXTextField *PassText;

@property (nonatomic,strong) UIButton *LoginBtn;
@property (nonatomic,strong) UIButton *countBtn;

@end

@implementation LoginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imaV = [[UIImageView alloc] initWithFrame:self.view.frame];
    imaV.image = [UIImage imageNamed:@"Logbg"];
    [self.view addSubview:imaV];
    
    [self AddViewloginOrOut];
}
#pragma mark ----登录注册------
-(void)AddViewloginOrOut{
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW/2-50, 60, 100, 70)];
    imageview.image = IMAGE_NAMED(@"logo");
    [self.view addSubview:imageview];
    
    CGRect accountF = CGRectMake(50, 210, KScreenW-100, 40);
    ZXTextField *TELText = [[ZXTextField alloc]initWithFrame:accountF withIcon:@"ICON_login" withPlaceholderText:@"请输入手机号码"];
    TELText.inputText.tag=204;
    TELText.inputText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    TELText.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    TELText.inputText.keyboardType = UIKeyboardTypeASCIICapable;
    TELText.frame = accountF;
    TELText.inputText.delegate = self;
    [self.view addSubview:TELText];
    self.TelText = TELText;
    
    ZXTextField *textfild = [[ZXTextField alloc]initWithFrame:CGRectMake(0, 0, KScreenW-100, 40) withIcon:@"ICON_mima" withPlaceholderText:@"密码"];
    textfild.inputText.tag = 205;
    textfild.inputText.secureTextEntry = YES;
    textfild.inputText.autocorrectionType = UITextBorderStyleNone;
    textfild.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    textfild.inputText.keyboardType = UIKeyboardTypeASCIICapable;
    textfild.inputText.delegate = self;
    [self.view addSubview:textfild];
    self.PassText = textfild;
    
    [textfild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(60);
        make.left.mas_equalTo(TELText);
        make.right.mas_equalTo(TELText);
        make.height.offset(40);
    }];
    
    

    /*
     登录按钮
     */
    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBtn.layer.cornerRadius = 20.0f;
    _LoginBtn.layer.masksToBounds = YES;
    [_LoginBtn setBackgroundColor:[UIColor whiteColor]];

    [_LoginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(makeSureBtn) forControlEvents:UIControlEventTouchUpInside];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _LoginBtn.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15];
    [self.view addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_PassText).with.offset(40+50);
        make.left.offset(57.5);
        make.right.offset(-57.5);
        make.height.offset(40.0);
    }];
    
    
    /*
     忘记密码按钮
     */
    
    UIButton *passBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [passBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [passBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    passBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [passBtn addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:passBtn];
    [passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_LoginBtn).with.offset(15+40);
        make.left.offset(50);
        make.width.offset((KScreenW-200)/2);
        make.height.offset(30);
    }];
    
    /*
     快速注册按钮
     */
    
    UIButton *FastlogBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [FastlogBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [FastlogBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    FastlogBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [FastlogBtn addTarget:self action:@selector(fastLoginin) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:FastlogBtn];
    [FastlogBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_LoginBtn).with.offset(15+40);
        make.right.offset(-50);
        make.width.offset((KScreenW-200)/2);
        make.height.offset(30);
    }];
    
//    [self otherLogSubviews];
    CGFloat btnW = 60;
    CGFloat btnH = 30;
    _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenW - btnW - 24, btnH, btnW, btnH)];
    [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_countBtn setTitle:@"跳过" forState:UIControlStateNormal];
    _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_countBtn setTitleColor:RGB(69, 163, 229) forState:UIControlStateNormal];
    _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
    _countBtn.layer.cornerRadius = 4;
    [self.view addSubview:_countBtn];


    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    
    
    [self.view addGestureRecognizer:tapGr];
}
#pragma mark ----其他登录方式的布局------
-(void)otherLogSubviews{

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.text = @"———————其他登录方式——————";
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=KWhiteColor;
    label.font = [UIFont systemFontOfSize:14.0];
    //[self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_LoginBtn).with.offset(40+75);
        make.left.offset(50);
        make.height.offset(20);
        make.right.offset(-50);
    }];
    
    UIButton *QQbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [QQbtn setImage:[UIImage imageNamed:@"QQ"] forState:0];
    [QQbtn addTarget:self action:@selector(tiredLoginin) forControlEvents:UIControlEventTouchUpInside];

    //[self.view addSubview:QQbtn];
    [QQbtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(label).offset(20+29);
        make.left.offset(KScreenW/2-44-31-20);
        make.width.offset(44);
        make.height.offset(44);
    }];
    
    UIButton *WXbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [WXbtn setImage:[UIImage imageNamed:@"wechat"] forState:0];
    [WXbtn addTarget:self action:@selector(tiredLoginin) forControlEvents:UIControlEventTouchUpInside];

    //[self.view addSubview:WXbtn];
    [WXbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(label).offset(20+29);
        make.left.offset(KScreenW/2-22);
        make.width.offset(44);
        make.height.offset(44);
    }];
    
    UIButton *WBbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [WBbtn setImage:[UIImage imageNamed:@"icon_weibo"] forState:0];
    [WBbtn addTarget:self action:@selector(tiredLoginin) forControlEvents:UIControlEventTouchUpInside];

    //[self.view addSubview:WBbtn];
    [WBbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(label).offset(20+29);
        make.left.offset(KScreenW/2+22+31);
        make.width.offset(44);
        make.height.offset(44);
    }];
    
    
//    [self addSubview:_adView];

    
}



#pragma mark   -------用户登录按钮----
-(void)makeSureBtn{
    if (self.TelText.inputText.text.length<1) {
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.confirmTitle=@"确定";
        
        configration.messageAlignment = NSTextAlignmentCenter;
        configration.message = @"请填写手机号";
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            
        }];
        
        [alerView show];
    }else if (self.PassText.inputText.text.length<6 || self.PassText.inputText.text.length>15){
        
        IBConfigration *configration = [[IBConfigration alloc] init];
        configration.title = @"提示";
        configration.confirmTitle=@"确定";
        
        configration.messageAlignment = NSTextAlignmentCenter;
        configration.message = @"密码格式不对，请重新填写";
        IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
            
        }];
        
        [alerView show];
        
    } else{
        [self sendmessage];
        
    }
    
    
}
//网络请求
-(void)sendmessage{
    
    NSDictionary *dic = @{@"mobile":self.TelText.inputText.text,
                          @"password":self.PassText.inputText.text,
                          };
    
    [MBProgressHUD showMessage:@"正在加载..."];
    NSString *utf = [LoginPassUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[HttpRequest sharedInstance] postWithURLString:utf parameters:dic success:^(id responseObject) {
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        NSDictionary *dict = responseObject;
        NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];

        ASLog(@"登陆页的信息%@",dict);
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"操作成功"];
            
            [self dismiss];
            
            [self saveuserinfoWithdic:dict[@"user"]];
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"uuid"] forKey:SectionID];
 
        
            NSLog(@"----个人信息-%@，%@----%@",[kApp getusermodel],SectionID,dict[@"uuid"]);
            
            if (self.myRegistblock) {
                _myRegistblock();
            }
            
            //存储用户手机号和密码
            kApp.userPhone = self.TelText.inputText.text;
            kApp.userPassWord = self.PassText.inputText.text;

        }else if ([code isEqualToString:@"2"])
        {
            NSString *message = [NSString stringWithFormat:@"%@",dict[@"msg"]];

            [MBProgressHUD showError:message];
        }else
        {
            NSString *message = [NSString stringWithFormat:@"%@",dict[@"msg"]];

            [MBProgressHUD showError:message];
        }
        
    } failure:^(NSError *error) {
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [MBProgressHUD showError:@"操作失败，请稍后重试"];
        [MBProgressHUD hideHUD];
    }];
}
#pragma mark ——————存储用户信息和登陆状态——————
-(void)saveuserinfoWithdic:(NSDictionary *)dic{


    
    userModel *usermodel = [[userModel alloc] init];
    usermodel.Id = dic[@"id"];
    usermodel.niceName = dic[@"niceName"];
    usermodel.phone = dic[@"phone"];
    usermodel.state = dic[@"state"];
    usermodel.loginDate = dic[@"loginDate"];
    usermodel.picture = dic[@"picture"];
    usermodel.password = dic[@"password"];
    usermodel.createTime = dic[@"createTime"];

    //    [kUserDefaults setObject:usermodel forKey:kUserinfoKey];
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:usermodel forKey:kUserinfoKey];
    // 归档结束.
    [archiver finishEncoding];
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weather"];
    [data writeToFile:file atomically:YES];

}

//存储用户头像
-(void)saveHeaderImage{


    
}

-(void)forgetPassWord{
    RegistViewController *reistVC = [[RegistViewController alloc] init];
    reistVC.titlestr = @"忘记密码";
    reistVC.urlstr = resetPasswUrl;
    reistVC.loginBtntitle = @"重置密码";
    [self presentViewController:reistVC animated:YES completion:nil];



}

-(void)fastLoginin{
    RegistViewController *reistVC = [[RegistViewController alloc] init];
    reistVC.titlestr = @"注册";
    reistVC.urlstr =registUrl;
    reistVC.loginBtntitle = @"提交注册";
    [self presentViewController:reistVC animated:YES completion:nil];


}
-(void)dismiss{

    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tiredLoginin{
    NSLog(@"三方登录");

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.text.length <= 0 && textField.tag ==204) {
        
        [self.TelText textBeginEditing];
        
    }else if (textField.text.length <= 0 && textField.tag ==205){
        
        [self.PassText textBeginEditing];
    
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length <= 0 && textField.tag ==204) {
        [self.TelText textEndEditing];
        
    }else if (textField.text.length <= 0 && textField.tag ==205){
        [self.PassText textEndEditing];
    }
}



-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.TelText.inputText resignFirstResponder];
    [self.PassText.inputText resignFirstResponder];
//    [self.PassText textEndEditing];
//    [self.TelText textEndEditing];
//
}

-(void)sendMessage{
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
