//
//  CenterView.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/10.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "CenterView.h"
#import "buttonView.h"




//整个布局的高度
#define cellHeight 15.0f

//宽度
#define viewW 45.0f

@interface CenterView()

@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) NSArray *titleArr;

@end

@implementation CenterView

-(instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr andtitle:(NSArray *)titleArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        _imageArr = imageArr;
        _titleArr = titleArr;
        [self addsubviews];
    }
    return self;

}
-(void)addsubviews{
    
    
    
    for (int i = 0; i<_imageArr.count; i++) {
        //总间距宽度
        float AllW = KScreenW - _imageArr.count*viewW;
        //半间距
        float distanceW =AllW/_imageArr.count/2;
        NSInteger tag = BTN_TAG+i;
        buttonView *buttonview = [[buttonView alloc] initWithFrame:CGRectMake(distanceW+distanceW*2*i+viewW*i, cellHeight, viewW, viewW+30) image:[UIImage imageNamed:_imageArr[i]] andtitle:_titleArr[i] andTag:tag];
        [self addSubview:buttonview];
    }
    
}

@end
