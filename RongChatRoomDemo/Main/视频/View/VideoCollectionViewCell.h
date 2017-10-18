//
//  VideoCollectionViewCell.h
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/23.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImv;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *dataLB;
@end
