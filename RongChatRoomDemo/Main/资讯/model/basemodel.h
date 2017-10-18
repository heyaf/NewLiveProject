//
//  basemodel.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/9/7.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface basemodel : JSONModel

@property (nonatomic, strong) NSString <Optional>*Id;
@property (nonatomic, strong) NSString <Optional>*updateTime;
@property (nonatomic, strong) NSString <Optional>*newsCategoryId;

@property (nonatomic, strong) NSString <Optional>*newsTop;

@property (nonatomic, strong) NSString <Optional>*picture;

@property (nonatomic, strong) NSString <Optional>*comment;

@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*newsCount;
@property (nonatomic, strong) NSString <Optional>*createTime;
@property (nonatomic, strong) NSString <Optional>*newsDelete;
@property (nonatomic, strong) NSString <Optional>*cover;
@property (nonatomic, strong) NSString <Optional>*newsType;
@property (nonatomic, strong) NSString <Optional>*newsSort;
@property (nonatomic, strong) NSString <Optional>*updateID;
@property (nonatomic, strong) NSString <Optional>*companyId;
@property (nonatomic, strong) NSString <Optional>*content;



@end
