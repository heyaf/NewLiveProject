//
//  OwnerViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/30.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "OwnerViewController.h"
#import "SubnameViewController.h"
#import "SubpassViewController.h"
#import "LDActionSheet.h"
#import "LDImagePicker.h"

@interface OwnerViewController ()<UITableViewDelegate,UITableViewDataSource,LDActionSheetDelegate,LDImagePickerDelegate>
@property (nonatomic, strong) LDActionSheet *originSheet;
@property (nonatomic, strong) LDActionSheet *customSheet;

@property (nonatomic,strong) UIImage *headerimage;
@property (nonatomic,strong) NSString *Imageurl;

@end

@implementation OwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(242, 242, 242);
    
    _headerimage = [UIImage imageNamed:@"icon_head"];
    self.owentableview.delegate = self;
    self.owentableview.dataSource = self;
    self.submitbtn.backgroundColor = RGB(69, 163, 229);
    
}
-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    NSString *sectionID = [[NSUserDefaults standardUserDefaults] objectForKey:SectionID];
    if (sectionID.length<=0) {
        self.submitbtn.selected = YES;

    }else{
    
        self.submitbtn.selected = NO;
    }
    if (_owentableview) {
        [self.owentableview reloadData];
    }
    
}
- (IBAction)submitBtn:(id)sender {
    NSString *sectionID = [[NSUserDefaults standardUserDefaults] objectForKey:SectionID];
    if (!self.submitbtn.selected) {
        NSDictionary*dic =@{@"uuid":sectionID,
                            
                            };
        ASLog(@".....%@",dic);
        
        [[HttpRequest sharedInstance] postWithURLString:QuartUrl parameters:dic success:^(id responseObject) {
             [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [MBProgressHUD hideHUD];
            [kApp userToZero];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
            
            
            [self.owentableview reloadData];
            if (self.changeblock) {
                _changeblock();
            }
            
            self.submitbtn.selected = YES;
            [self.submitbtn setTintColor:KGrayColor];
            self.submitbtn.backgroundColor = KGrayColor;
            
            
            [MBProgressHUD showSuccess:@"操作成功"];


            [[NSUserDefaults standardUserDefaults] removeObjectForKey:SectionID];
            
            
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"出错了，请重试"];
            [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];

            [MBProgressHUD hideHUD];
            ASLog(@"退出登录出错了%@",error.description);
            
            
        }];

        
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    if (section ==0) {
        return 2;
    }else{
    
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    userModel *user = [kApp getusermodel];
    if (indexPath.section==0&&indexPath.row==0) {
//        cell.imageView.image = _headerimage;
        cell.textLabel.text = @"头像";
        cell.detailTextLabel.text = @">";
        
    }else if(indexPath.section==0&&indexPath.row==1){
        cell.textLabel.text = @"昵称";
        NSString *name = user.niceName;
        if (name.length==0) {
            name = @"";
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  >",name];
    
    }else if (indexPath.section==1){
        cell.textLabel.text = @"修改密码";
        cell.detailTextLabel.text = @">";
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0&&indexPath.row==0) {
   
        self.originSheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄",@"相册", nil];
        [self.originSheet showInView:self.view];
        
    }else if(indexPath.section==0&&indexPath.row==1){
        SubpassViewController *subpassVC = [[SubpassViewController alloc] init];
        subpassVC.navigationItem.title = @"修改昵称";
        [self.navigationController pushViewController:subpassVC animated:YES];
        
    }else if (indexPath.section==1){
        SubnameViewController *subnameVC = [[SubnameViewController alloc] init];
        subnameVC.title = @"修改密码";
        [self.navigationController pushViewController:subnameVC animated:YES];
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20;
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([actionSheet isEqual:self.customSheet]) {
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showImagePickerWithType:buttonIndex InViewController:self Scale:0.75];
    }else{
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        [imagePicker showOriginalImagePickerWithType:buttonIndex InViewController:self];
    }
    
}

- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{

    userModel *model =[kApp getusermodel];
    if (model.Id.length < 1) {
        [kApp showMessage:@"提示" contentStr:@"请先登录"];
    }else{
    
    NSData *data = UIImageJPEGRepresentation([UIImage cropImage:editedImage scale:CGSizeMake(0.1, 0.1)] , 0.1);
    
//    NSMutableDictionary *imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
//    imageDic[@"id"] = model.Id;
//    imageDic[@"file"] = data;
    [MBProgressHUD showMessage:@"正在加载..."];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/xml", @"application/x-javascript", @"text/plain", nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:updateImage parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:@"image.png" mimeType:@"image/png"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

        NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dicJson[@"state"] isEqualToString:@"1"]) {
            _Imageurl = dicJson[@"data"];
            NSDictionary *parement =@{@"id":model.Id,
                                      @"picture":_Imageurl,
                                      @"uuid":[[NSUserDefaults standardUserDefaults] objectForKey:SectionID]
                                      };
//            NSLog(@"上传图片......%@",_Imageurl);

            [[HttpRequest sharedInstance] postWithURLString:Updateusers parameters:parement success:^(id responseObject) {
                 [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                [MBProgressHUD hideHUD];
                NSDictionary *dict = responseObject;
                NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
                
                if ([code isEqualToString:@"1"]) {
                    
                    [MBProgressHUD showSuccess:@"操作成功"];

                    [kApp userToZero];
                    [self saveuserinfoWithdic:model angStr:_Imageurl];
                    
                    
//                    NSLog(@"上传图片......%@",[kApp getusermodel]);
                    
                }else
                {
                    NSString *message = [NSString stringWithFormat:@"%@",dict[@"msg"]];
                    
                    [MBProgressHUD showError:message];
                    ASLog(@"..返回的..%@",dict);
                }
            } failure:^(NSError *error) {
                 [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"操作失败，请稍后重试"];
                ASLog(@"..上传图片失败...%@",error.description);
            }];
            
            
            
            [UIImage SaveImageToLocal:editedImage Keys:kHeaderImageKey];
            if (self.changeblock) {
                _changeblock();
            }

        }else{
        
            [MBProgressHUD showError:dicJson[@"msg"]];
            ASLog(@"------......%@",dicJson);
        }

 
            
        
        
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"操作失败"];
//        NSLog(@"上传图片shibai%@",error.description);
    }];
   
    
    
    }
}

-(void)saveuserinfoWithdic:(userModel *)model angStr:(NSString *)picStr{
    
    
    
    userModel *usermodel = [[userModel alloc] init];
    usermodel.Id = model.Id;
    usermodel.niceName = model.niceName;
    usermodel.phone = model.phone;
    usermodel.state = model.state;
    usermodel.loginDate = model.loginDate;
    usermodel.picture = picStr;
    usermodel.password = model.password;
    usermodel.createTime = model.createTime;
    //    usermodel.niceName = dic[@""];
    //    usermodel.niceName = dic[@""];
    //    usermodel.niceName = dic[@""];
    //    usermodel.niceName = dic[@""];
    //    usermodel.niceName = dic[@""];
    //    usermodel.niceName = dic[@""];
    //    usermodel.niceName = dic[@""];
    //    usermodel.niceName = dic[@""];
    //
    //
    //    property (nonatomic, strong) NSString <Optional>*identity;
    //    @property (nonatomic, strong) NSString <Optional>*phone;
    //    @property (nonatomic, strong) NSString <Optional>*state;
    //    @property (nonatomic, strong) NSString <Optional>*loginDate;
    //    @property (nonatomic, strong) NSString <Optional>*wechat;
    //    @property (nonatomic, strong) NSString <Optional>*picture;
    //    @property (nonatomic, strong) NSString <Optional>*password;
    //    @property (nonatomic, strong) NSString <Optional>*signature;
    //    @property (nonatomic, strong) NSString <Optional>*createTime;
    //    @property (nonatomic, strong) NSString <Optional>*alterDate;
    //    @property (nonatomic, strong) NSString <Optional>*qq;
    //    @property (nonatomic, strong) NSString <Optional>*email;
    //    @property (nonatomic, strong) NSString <Optional>*name;
    //    @property (nonatomic, strong) NSString <Optional>*certification;
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
