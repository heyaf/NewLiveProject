//
//  News2TableViewCell.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/17.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News2TableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *titleImageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIImageView *countryImv;
@end
