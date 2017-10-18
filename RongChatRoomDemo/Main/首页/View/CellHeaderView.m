//
//  CellHeaderView.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/10.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "CellHeaderView.h"

@implementation CellHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        [self addsubviewsWithFrame:frame];
    }
    return self;
}

-(void)addsubviewsWithFrame:(CGRect)frame{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 13, 14)];
    imageview.image = [UIImage imageNamed:@"icon_hot"];
    [self addSubview:imageview];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(44, 13, 32, 15)];
    label.text = @"热点";
    label.textColor = RGB(246, 111, 52);
    label.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:label];
    
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW-67, 13, 32, 15)];
        label2.text = @"更多";
        label2.textColor = RGB(152, 153, 153);
        label2.font = [UIFont systemFontOfSize:15.0];
    
        [self addSubview:label2];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(KScreenW-83, 5, 50, 32);
    [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor grayColor];
//    btn.titleLabel.text = @"更多";
//    btn.titleLabel.backgroundColor =[UIColor grayColor];
//    btn.titleLabel.textColor = KBlackColor;
//    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    
    [self addSubview:btn];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW-28, 13, 8, 14)];
    imageview1.image = [UIImage imageNamed:@"icon_more"];
    [self addSubview:imageview1];

    

    
    
    
    
}

-(void)buttonClick{

    BaseCellViewController *basevc = [[BaseCellViewController alloc] init];
    basevc.sizeH = KScreenH;
    basevc.title = @"热点";
    basevc.urlString = MessageHotNewsUrl;
    basevc.parament = @{@"pageSize":@"20"};
    [[kApp getCurrentUIVC].navigationController pushViewController:basevc animated:YES];
}

@end
