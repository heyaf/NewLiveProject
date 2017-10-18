//
//  BaseCellViewController.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/15.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCellViewController : UIViewController

@property (nonatomic,strong) NSArray *dateArr;
@property (nonatomic,strong) NSString *urlString;

@property (nonatomic,strong) UIView *parentview;
@property (nonatomic,strong) NSDictionary *parament;
//界面高度
@property (nonatomic,assign) CGFloat sizeH;
@property (nonatomic,assign) BOOL isSearchNews;
//-(void)showprogress:(NSString *)

-(void)creatDatawithpage:(NSInteger) pagenumber andaddData:(BOOL) adddata;
@end
