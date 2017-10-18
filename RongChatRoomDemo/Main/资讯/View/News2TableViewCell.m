//
//  News2TableViewCell.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/17.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "News2TableViewCell.h"

@implementation News2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleImageV = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"1")];
    [self addSubview:_titleImageV];
    self.countryImv.layer.masksToBounds = YES;
    self.countryImv.layer.cornerRadius = 5.0f;
    [_titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(5);
        make.bottom.mas_offset(0);
        make.width.mas_offset(1);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
