//
//  suggestViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/29.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "suggestViewController.h"

@interface suggestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *SuggetsTF;
@property (weak, nonatomic) IBOutlet UITextField *suggestTF;
@property (weak, nonatomic) IBOutlet UITextField *connectTX;
@property (weak, nonatomic) IBOutlet UIButton *submitBTN;

@end

@implementation suggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(242, 242, 242);
   
    self.navigationItem.title = @"用户反馈";
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    

   self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated{

//    self.navigationController.navigationBarHidden =YES;
}
- (IBAction)submitbtn:(id)sender {
    userModel *user = [kApp getusermodel];
    NSLog(@"%@",self.SuggetsTF.text);
    if (self.suggestTF.text.length>0) {
        NSDictionary *dict =@{@"content":self.SuggetsTF.text,
                              @"userid":user.Id,
                              @"userType":@"1",
                              @"tel":self.connectTX.text
                              };
        [MBProgressHUD showMessage:@"请稍候..."];
        NSString *utf = [SuggestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[HttpRequest sharedInstance] postWithURLString:utf parameters:dict success:^(id responseObject) {
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
            [MBProgressHUD hideHUD];
            
            [MBProgressHUD showError:@"操作失败，请稍后重试"];
        }];
    }else{
        
        [kApp showMessage:@"提醒" contentStr:@"请填写您的意见"];
    }

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
