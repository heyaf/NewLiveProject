//
//  HeaderView.h
//  text
//
//  Created by 弘鼎 on 2017/7/28.
//  Copyright © 2017年 贺亚飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;
@interface HeaderView : UIView

@property (nonatomic,strong) NSString *titleStr;
@property (nonatomic,strong) NSString *nameStr;
@property (nonatomic,strong) NSString *countStr;
@property (nonatomic,strong) NSString *dataStr;

//是否有收藏按钮
@property (nonatomic,assign) BOOL select;
//收藏按钮是否变♥️
@property (nonatomic,assign) BOOL ifselected;


-(instancetype)initWithFrame:(CGRect)frame andVideomodel:(VideoModel *)videomodel isselected:(BOOL)isSelect;


@end
