//
//  XieYiViewController.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/10/19.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "XieYiViewController.h"

@interface XieYiViewController ()
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)BackBtn:(id)sender {
//    NSLog(@"............");
 [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
