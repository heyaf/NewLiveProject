//
//  News2HeaderView.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/17.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface News2HeaderView : UIView
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;
-(void)changeTitleWithStr:(NSString *)str;
@end
