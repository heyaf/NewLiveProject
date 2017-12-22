//
//  HeaderView.m
//  text
//
//  Created by 弘鼎 on 2017/7/28.
//  Copyright © 2017年 贺亚飞. All rights reserved.
//

#import "HeaderView.h"
#import "VideoModel.h"
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

@interface HeaderView ()

@property (nonatomic,strong) VideoModel *mymodel;
@property (nonatomic,strong) UIButton *selectBtn;

@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame andVideomodel:(VideoModel *)videomodel isselected:(BOOL)isSelect{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =RGB(220, 220, 220);
        _mymodel = videomodel;
        self.select = isSelect;
        [self addsubviewsWithFrame:frame];
        if (isSelect) {
            [self getmessageWithUrl:ChargeVideoCollection];

        }
        
    }
    return self;
}

-(void)addsubviewsWithFrame:(CGRect)frame{
    

    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, (KScreenW-15-15)/2, 30)];
    titleLable.textAlignment=NSTextAlignmentLeft;
    titleLable.font = [UIFont systemFontOfSize:15.0];
    titleLable.text = @"汇市风云，股海狂潮";
    titleLable.textColor = RGB(51, 51, 51);
    [self addSubview:titleLable];
    
    
    UILabel *leaderLB = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW-15-15)/2, 15, 20+(KScreenW-15-15)/2, 30)];
    leaderLB.textAlignment = NSTextAlignmentRight;
    leaderLB.font = [UIFont systemFontOfSize:15.0];
    leaderLB.textColor = RGB(51, 51, 51);
    leaderLB.text = @"主讲人：致赢团队";
    [self addSubview:leaderLB];
    
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 25)];
    view.font = [UIFont systemFontOfSize:12.0f];
    view.textColor = RGB(153, 153, 153);
    view.text = @"1668人观看";
    [self addSubview:view];
    
    UILabel *dataLB = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 120, 25)];
    dataLB.font = [UIFont systemFontOfSize:12.0f];
    dataLB.textColor = RGB(153, 153, 153);
    dataLB.text = @"2017-09-26";
    [self addSubview:dataLB];

    if (_mymodel.title.length>0) {
        
        titleLable.text = _mymodel.title;
        
        leaderLB.text = [NSString stringWithFormat:@"主讲人：%@",_mymodel.content];
        view.text = [NSString stringWithFormat:@"%@人观看",_mymodel.count];
        
        dataLB.text = _mymodel.date;
    }
    
    UIButton *selcetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selcetBtn.frame = CGRectMake(KScreenW-50, 40, 44, 44);
    [selcetBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _selectBtn = selcetBtn;
    if (_select) {
    
        [self addSubview:selcetBtn];
    }
    
    
    
    
}
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}
-(void)clickBtn{
    
    if (_ifselected) {
        [self sendmessageWithUrl:UnCollectionVideo];
        [_selectBtn setImage:[UIImage imageNamed:@"icon_collection_defaul"] forState:UIControlStateNormal];

    }else{
        
         [_selectBtn setImage:[UIImage imageNamed:@"icon_collection_selected"] forState:UIControlStateNormal];
        [self sendmessageWithUrl:CollectionVideo];
    }


    
}
//看当前是否收藏
-(void)getmessageWithUrl:(NSString *)url {
   
    
    
    userModel *user = [kApp getusermodel];
    if (user.Id.length<1) {
        
    }else{
    
        NSDictionary *dic =@{@"userType":@"1",
                             @"userId":user.Id,
                             @"vedioId":_mymodel.Id
                             
                             };
        
        NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[HttpRequest sharedInstance] postWithURLString:utf parameters:dic success:^(id responseObject) {
            //         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            NSDictionary *dict = responseObject;
            NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
            
            
            if ([code isEqualToString:@"1"]) {
                _ifselected = YES;
                [_selectBtn setImage:[UIImage imageNamed:@"icon_collection_selected"] forState:UIControlStateNormal];
                
            }else if ([code isEqualToString:@"0"])
            {
                _ifselected = NO;
                [_selectBtn setImage:[UIImage imageNamed:@"icon_collection_defaul"] forState:UIControlStateNormal];
            }
        } failure:^(NSError *error) {
            //         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            
            [MBProgressHUD showError:@"操作失败，请稍后重试"];
        }];

    }
    
    }
-(void)sendmessageWithUrl:(NSString *)url {
    
    
    userModel *user = [kApp getusermodel];
    if (user.Id.length < 1) {
        [kApp showMessage:@"提示" contentStr:@"请先登录"];
    }else{
        NSDictionary *dic =@{@"userType":@"1",
                             @"userId":user.Id,
                             @"vedioId":_mymodel.Id                             
                             };
//        NSLog(@"-----------------%@",dic);
        NSString *utf = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        MBProgressHUD * hud1 = [MBProgressHUD showHUDAddedTo: [UIApplication sharedApplication].keyWindow animated:YES];
        [[[UIApplication sharedApplication].windows lastObject] addSubview:hud1];
        //    NSLog(@"0....0%@",self.url);
        hud1.labelText = NSLocalizedString(@"正在加载...", @"HUD loading title");
        [[HttpRequest sharedInstance] postWithURLString:utf parameters:dic success:^(id responseObject) {
             [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [MBProgressHUD hideHUD];
            NSDictionary *dict = responseObject;
//            NSLog(@"123456%@",dict);
            NSString *code = [NSString stringWithFormat:@"%@",dict[@"state"]];
            
            
            
            if ([code isEqualToString:@"1"]) {
                NSString *message = [NSString stringWithFormat:@"%@",dict[@"msg"]];
                [MBProgressHUD showSuccess:message];
                
                if ([url isEqualToString:CollectionVideo]) {
                    //收藏成功
                    _ifselected = YES;
                    [_selectBtn setImage:[UIImage imageNamed:@"icon_collection_selected"] forState:UIControlStateNormal];
                }else{
                    //取消收藏成功
                    [_selectBtn setImage:[UIImage imageNamed:@"icon_collection_defaul"] forState:UIControlStateNormal];
                    
                    _ifselected = NO;
                }
                
                
            }else  {
                NSString *message = [NSString stringWithFormat:@"%@",dict[@"msg"]];
                
                [MBProgressHUD showError:message];
            }
        } failure:^(NSError *error) {
             [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"操作失败，请稍后重试"];
            NSLog(@"%@",error.description);
        }];
    }
}

@end
