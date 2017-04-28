//
//  DKDownloaderOP.m
//  01-仿SD框架
//
//  Created by doublek on 2017/3/3.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import "DKDownloaderOP.h"

@interface DKDownloaderOP ()

@property(nonatomic,strong)NSURL *url;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)void(^bk)(UIImage *);

@end

@implementation DKDownloaderOP

+(instancetype)wedUIImageOpWithURL:(NSURL *)url andWithSucceBlock:(void (^)(UIImage *))bk{
    
    DKDownloaderOP *op = [[self alloc]init];
    
    op.url = url;
    
    op.bk = bk;
    
    return op;
}

-(void)main{
    
    [NSThread sleepForTimeInterval:1];
    
    if (self.isCancelled) {
        
        NSLog(@"操作被取消");
        return;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:self.url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    //要让主线程刷新UI
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        self.bk(image);
    }];
    
}


@end
