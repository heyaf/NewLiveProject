//
//  userModel.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/5.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface userModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*Id;

@property (nonatomic, strong) NSString <Optional>*niceName;

@property (nonatomic, strong) NSString <Optional>*identity;
@property (nonatomic, strong) NSString <Optional>*phone;
@property (nonatomic, strong) NSString <Optional>*state;
@property (nonatomic, strong) NSString <Optional>*loginDate;
@property (nonatomic, strong) NSString <Optional>*wechat;
@property (nonatomic, strong) NSString <Optional>*picture;
@property (nonatomic, strong) NSString <Optional>*password;
@property (nonatomic, strong) NSString <Optional>*signature;
@property (nonatomic, strong) NSString <Optional>*createTime;
@property (nonatomic, strong) NSString <Optional>*alterDate;
@property (nonatomic, strong) NSString <Optional>*qq;
@property (nonatomic, strong) NSString <Optional>*email;
@property (nonatomic, strong) NSString <Optional>*name;
@property (nonatomic, strong) NSString <Optional>*certification;



@end
