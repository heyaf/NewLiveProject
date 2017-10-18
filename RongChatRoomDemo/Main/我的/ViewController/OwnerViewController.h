//
//  OwnerViewController.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/30.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChangeBlock)();
@interface OwnerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *owentableview;
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;
@property (copy,nonatomic) ChangeBlock changeblock;

@end
