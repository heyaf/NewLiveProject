//
//  HomeTableViewCell.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/11.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()



@end
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setsubviews];
}
-(void)setsubviews{
    _titleLB.numberOfLines = 0;
    _titleLB.textAlignment = NSTextAlignmentLeft;
    _titleLB.font = [UIFont systemFontOfSize:13.0];
    
    _numberLB.textAlignment = NSTextAlignmentLeft;
    _numberLB.font = [UIFont systemFontOfSize:12.0];
    _numberLB.textColor = RGB(153, 153, 153);
    
    _dateLB.textAlignment = NSTextAlignmentRight;
    
    _dateLB.font = [UIFont systemFontOfSize:12.0];
    _dateLB.textColor = RGB(153, 153, 153);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
