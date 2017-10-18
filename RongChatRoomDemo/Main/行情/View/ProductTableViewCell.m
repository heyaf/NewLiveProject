//
//  ProductTableViewCell.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/28.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btnLB.layer.masksToBounds = YES;
    self.btnLB.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
