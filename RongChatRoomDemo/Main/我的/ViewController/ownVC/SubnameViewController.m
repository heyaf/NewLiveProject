//
//  SubnameViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/30.
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


#import "SubnameViewController.h"
//#import "ZXTextField.h"
#import <Masonry.h>

@interface SubnameViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *TelText;
@property (nonatomic,strong) UITextField *PassText;

@property (nonatomic,strong) UIButton *LoginBtn;


@end

@implementation SubnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =RGB(242, 242, 242);
    [self AddViewloginOrOut];
}

-(void)AddViewloginOrOut{
    
    
    CGRect accountF = CGRectMake(50, 40, KScreenW-100, 40);
    UITextField *TELText = [[UITextField alloc] initWithFrame:accountF];
    TELText.placeholder = @"旧密码";
    TELText.frame = accountF;
    TELText.delegate = self;
    [self.view addSubview:TELText];
    self.TelText = TELText;
    
    UITextField *textfild = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, KScreenW-100, 40) ];
   textfild.placeholder = @"6～15位新密码";
    [self.view addSubview:textfild];
    self.PassText = textfild;
    
    [textfild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TELText).with.offset(60);
        make.left.mas_equalTo(TELText);
        make.right.mas_equalTo(TELText);
        make.height.offset(40);
    }];
    
    
   
    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _LoginBtn.layer.cornerRadius = 20.0f;
    _LoginBtn.layer.masksToBounds = YES;
    [_LoginBtn setBackgroundColor:[UIColor whiteColor]];
    
    [_LoginBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_LoginBtn addTarget:self action:@selector(makeSureBtn) forControlEvents:UIControlEventTouchUpInside];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    _LoginBtn.backgroundColor = RGB(69, 163, 229);
    [self.view addSubview:_LoginBtn];
    [_LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_PassText).with.offset(40+50);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40.0);
    }];
}
-(void)makeSureBtn{
    userModel *user = [kApp getusermodel];
    if (user.Id.length < 1) {
        [kApp showMessage:@"提示" contentStr:@"请先登录"];
    }else{
    if (self.PassText.text.length>0 && self.TelText.text.length>0) {
        NSDictionary *dict =@{@"newPassword":self.PassText.text,
                              @"id":user.Id,
                              @"oldPassword":self.TelText.text                              
                              };
//        [MBProgressHUD showMessage:@"正在加载..."];

        NSString *utf = [UpdatePassusers stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[HttpRequest sharedInstance] postWithURLString:utf parameters:dict success:^(id responseObject) {
             [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [MBProgressHUD hideHUD];
            NSDictionary *dict = responseObject;
            NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
            
            
            if ([code isEqualToString:@"1"]) {
                
                [MBProgressHUD showSuccess:@"操作成功"];
                
                
            }else
            {
                NSString *message = [NSString stringWithFormat:@"%@",dict[@"msg"]];
                
                [MBProgressHUD showError:message];
            }
        } failure:^(NSError *error) {
             [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [MBProgressHUD hideHUD];
//            NSLog(@"%@",error);
            [MBProgressHUD showError:@"操作失败，请稍后重试"];
        }];
    }else if(self.TelText.text.length==0){
        
        [kApp showMessage:@"提醒" contentStr:@"请填写旧密码"];
    }else if(self.PassText.text.length==0){
        
        [kApp showMessage:@"提醒" contentStr:@"请填写新密码"];
    }

    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
   
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
   
}



-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.TelText resignFirstResponder];
    [self.PassText resignFirstResponder];
    //    [self.PassText textEndEditing];
    //    [self.TelText textEndEditing];
    //
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
