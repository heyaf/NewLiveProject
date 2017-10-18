//
//  LoginInViewController.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/8.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RegistBlock)();
@interface LoginInViewController : UIViewController
@property (nonatomic,copy) RegistBlock myRegistblock;
@end
