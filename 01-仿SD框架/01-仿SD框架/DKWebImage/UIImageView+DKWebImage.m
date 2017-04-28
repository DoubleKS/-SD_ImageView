//
//  UIImageView+DKWebImage.m
//  01-仿SD框架
//
//  Created by doublek on 2017/3/4.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import "UIImageView+DKWebImage.h"
#import "DKDownloadOpManager.h"
#import <objc/runtime.h>

@implementation UIImageView (DKWebImage)


-(void)setLastURL:(NSURL *)lastURL{
    
    //OC运行时
    objc_setAssociatedObject(self, @"last", lastURL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(NSURL *)lastURL{
    
    return objc_getAssociatedObject(self, @"last");
}

-(void)dk_setImageWithURL:(NSURL *)url{
    
    DKDownloadOpManager *manager = [DKDownloadOpManager shareManager];
    
    //需要在这里跟判断上一次冲突,如果不冲突,我要取消上一次的操作
    if (![url.description isEqualToString:self.lastURL.description]) {
        
        NSLog(@"上一条任务被取消了");
        //取消上一条操作对象
        [manager cancelLastOP:self.lastURL];
    }
    
    [manager managerWithURL:url andSuccesBlock:^(UIImage *img) {
        
        self.image = img;
    }];
    
    //知道上一次访问的是哪条任务
    self.lastURL = url;
    
}

-(void)dk_setImageWithURL:(NSURL *)url andPlaceHoldImg:(UIImage *)holdImg{

    
    if (holdImg) {
        
        self.image = holdImg;
    }
    
    DKDownloadOpManager *manager = [DKDownloadOpManager shareManager];
    
    //需要在这里跟判断上一次冲突,如果不冲突,我要取消上一次的操作
    if (![url.description isEqualToString:self.lastURL.description]) {
        
        //取消上一条操作对象
        [manager cancelLastOP:self.lastURL];
    }
    
    [manager managerWithURL:url andSuccesBlock:^(UIImage *img) {
        
        self.image = img;
    }];
    
    //知道上一次访问的是哪条任务
    self.lastURL = url;
    
}

@end
