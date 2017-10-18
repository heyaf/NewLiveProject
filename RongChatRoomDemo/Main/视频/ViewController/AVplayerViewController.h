//
//  AVplayerViewController.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/2.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoModel;
@interface AVplayerViewController : UIViewController
@property (nonatomic,strong) NSString *videourl;
@property (nonatomic,strong) VideoModel *videomodel;
@property (nonatomic,assign) BOOL RemoveBackBtn;
@end
