//
//  buttonView.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/10.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "buttonView.h"
#import "CompareViewController.h"
#import "News2ViewController.h"
#import "CalendarViewController.h"
#import "IBConfigration.h"

@implementation buttonView

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image andtitle:(NSString *)title andTag:(NSInteger)tag{

    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor =RGB(220, 220, 220);
        [self addsubviewsWithFrame:frame image:image andtitle:title];
        self.tagInt = tag;
    }
    return self;
}
-(void)addsubviewsWithFrame:(CGRect)frame image:(UIImage *)image andtitle:(NSString *)title{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width+10, frame.size.width, 20)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:label];
    
    
    
    
}

-(void)btnClicked{
    IBConfigration *configration = [[IBConfigration alloc] init];
    configration.title = @"提示";
    configration.message = @"敬请期待...";
    //        configration.cancelTitle = @"确定";
    configration.confirmTitle=@"确定";
    
    configration.messageAlignment = NSTextAlignmentCenter;
    
    IBAlertView *alerView = [IBAlertView alertWithConfigration:configration block:^(NSUInteger index) {
        
    }];
    
    UIViewController *vc = [self currentVc];
//    CompareViewController *compareVC = [[CompareViewController alloc] init];
    BaseCellViewController *basevc = [[BaseCellViewController alloc] init];
   
    basevc.sizeH = KScreenH;
//    new2VC.view.frame = CGRectMake(0, 64, KScreenW, KScreenH);
    CalendarViewController *calenderVC = [[CalendarViewController alloc] init];
    RootWebViewController *webVC = [[RootWebViewController alloc] init];
    webVC.url = MessageFastNewsUrl;
    switch (self.tagInt) {
        case BTN_TAG:

            basevc.title = @"分析";
            basevc.urlString = AnalyzeNewsUrl;
            [vc.navigationController pushViewController:basevc animated:YES];
            break;
        case BTN_TAG+1:
//            compareVC.title = @"竞赛";
//            [vc.navigationController pushViewController:compareVC animated:YES];

            [alerView show];
            break;
        case BTN_TAG+2:
            basevc.title = @"要闻";

            basevc.urlString = MessageNewsUrl;
            basevc.parament = @{@"NewscategoryID":@"1"};
            [vc.navigationController pushViewController:basevc animated:YES];
            break;
        case BTN_TAG+3:

  

            [vc.navigationController pushViewController:webVC animated:YES];
            break;
        case BTN_TAG+4:
            calenderVC.title = @"日历";
            [vc.navigationController pushViewController:calenderVC animated:YES];
            break;
        default:
            break;
    }
    
   
    
}
-(UIViewController *)currentVc{

    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
