//
//  buttonView.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/10.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface buttonView : UIView

//tag值
@property (nonatomic,assign) NSInteger tagInt;
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image andtitle:(NSString *)title andTag:(NSInteger)tag;

@end
