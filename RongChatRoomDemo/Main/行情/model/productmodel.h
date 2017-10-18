//
//  productmodel.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/13.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface productmodel : JSONModel
@property (nonatomic, strong) NSString <Optional>*highPic;
@property (nonatomic, strong) NSString <Optional>*lowPic;
@property (nonatomic, strong) NSString <Optional>*diffPer;
@property (nonatomic, strong) NSString <Optional>*code;
@property (nonatomic, strong) NSString <Optional>*buyPic;
@property (nonatomic, strong) NSString <Optional>*updateTime;
@property (nonatomic, strong) NSString <Optional>*diffAmo;
@property (nonatomic, strong) NSString <Optional>*currency;
@property (nonatomic, strong) NSString <Optional>*closePri;
@property (nonatomic, strong) NSString <Optional>*openPri;

@end
