//
//  UIImage+Cache.m
//  RongChatRoomDemo
//
//  Created by 弘鼎 on 2017/8/30.
//  Copyright © 2017年 rongcloud. All rights reserved.
//

#import "UIImage+Cache.h"

@implementation UIImage (Cache)
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:UIImagePNGRepresentation(image) forKey:key];
}
+ (UIImage*)GetImageFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
        image =[UIImage imageNamed:@"icon_head"];
    }
    return image;
}
+(void)uploadImageWithUrl:(NSString *)strUrl dataParams:(NSMutableDictionary *)dataParams imageParams:(NSMutableDictionary *) imageParams Success:(void(^)(NSDictionary *resultDic)) success Failed:(void(^)(NSError *error))fail {
    NSArray *keys = [imageParams allKeys];
    UIImage * image = [imageParams objectForKey:[keys firstObject]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];//对SSL做处理，防止上传失败AFSecurityPolicy
    AFSecurityPolicy* securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 120;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:strUrl parameters:dataParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:[keys firstObject] fileName:[NSString stringWithFormat:@"%@.jpeg",[keys firstObject]] mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) { success(responseObject); }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (fail) { fail(error); } }];
}

+(UIImage *)cropImage:(UIImage *)image scale:(CGSize)scale
{
    CGSize newSize = CGSizeMake(100,100);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
