//
//  News2HeaderView.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/17.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "News2HeaderView.h"

@interface News2HeaderView(){

    UILabel *titleLB;
}

@end

@implementation News2HeaderView

-(instancetype)initWithFrame:(CGRect)frame  andTitle:(NSString *)title{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addsubviewsWithTitle:title];
    }
    return self;
}
-(void)addsubviewsWithTitle:(NSString *)title{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 5, 15)];
    view.backgroundColor = RGB(39, 186, 240);
    [self addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, KScreenW-10, 20)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = RGB(39, 186, 240);
    titleLB= label;
    [self addSubview:label];
}
-(void)changeTitleWithStr:(NSString *)str{
    
    titleLB.text = str;

}

@end
