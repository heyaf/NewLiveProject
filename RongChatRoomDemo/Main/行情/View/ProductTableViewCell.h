//
//  ProductTableViewCell.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/28.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleLB;

@property (weak, nonatomic) IBOutlet UILabel *subtitleLB;
@property (weak, nonatomic) IBOutlet UILabel *newsLB;

@property (weak, nonatomic) IBOutlet UILabel *btnLB;

@end
