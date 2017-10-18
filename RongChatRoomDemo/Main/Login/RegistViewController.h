//
//  RegistViewController.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/1.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+Countdown.h"


@interface RegistViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (nonatomic,strong) NSString *titlestr;
@property (nonatomic,strong) NSString *loginBtntitle;

@property (nonatomic,strong) NSString *urlstr;


@end
