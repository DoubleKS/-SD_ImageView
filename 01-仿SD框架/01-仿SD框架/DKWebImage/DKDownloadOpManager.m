//
//  DKDownloadOpManager.m
//  01-仿SD框架
//
//  Created by doublek on 2017/3/3.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import "DKDownloadOpManager.h"
#import "DKDownloaderOP.h"
#import "NSString+DKAddition.h"

@interface DKDownloadOpManager ()

@property(nonatomic,strong)NSOperationQueue *queue;

//沙盒缓存
@property(nonatomic,strong)NSMutableDictionary *cacheOp;

//图片缓存
@property(nonatomic,strong)NSMutableDictionary *cacheImgs;

@end

@implementation DKDownloadOpManager

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static DKDownloadOpManager *obj = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        obj = [super allocWithZone:zone];
        //实例化
        obj.queue = [NSOperationQueue new];
        
        obj.cacheOp = [NSMutableDictionary dictionary];
        
        obj.cacheImgs = [NSMutableDictionary dictionary];
        
        //订阅内存警告的通知
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        //如果要接收内存警告的通知,就订阅
        [center addObserver:obj selector:@selector(clearCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];

    });
    
    return obj;
}

+(instancetype)shareManager{
    
    return [[self alloc]init];
}

-(void)clearCache{
    //清除所有缓存的图片
//    [self.cacheImgs removeAllObjects];
    
    //清除操作对象
    [self.cacheOp removeAllObjects];
    
    NSLog(@"清理缓存中...");
}


-(void)managerWithURL:(NSURL *)url andSuccesBlock:(void (^)(UIImage *))bk{
    
    //当控制器一旦调用我这个方法是为了下载
    if (self.cacheImgs[url.description]) {
        
        NSLog(@"从内存中读取");
        
        bk(self.cacheImgs[url.description]);
        
        return;
    }
    
    //去沙盒中找
    NSString *cachePath = [url.description dk_getImgPath];
    
    UIImage *img = [UIImage imageWithContentsOfFile:cachePath];
    
    if (img) {
        
        NSLog(@"冲沙盒中读取");
        //也保存到内存缓存中
        [self.cacheImgs setObject:img forKey:url.description];
        
        bk(img);
        
        return;
    }
    
    //创建操作对象
    DKDownloaderOP *op = [DKDownloaderOP wedUIImageOpWithURL:url andWithSucceBlock:^(UIImage *img) {
        
        if (img) {
            
            //存到内存缓存中
            
            [self.cacheImgs setObject:img forKey:url.description];
            
            //写入到沙盒中
            //得到要写入沙盒中的路径
            NSString *path = [url.description dk_getImgPath];
            
            //写的是SNData
            //UIImage转NSData
            NSData *data = UIImagePNGRepresentation(img);
            
            //写入到沙盒中
            [data writeToFile:path atomically:YES];
            
        }
        //不然self.cacheOP里元素只会越来越多
        [self.cacheOp removeObjectForKey:url];
        
        bk(img);
    }];
    
    
    //记录刚刚产生的操作对象
    [self.cacheOp setObject:op forKey:url];
    
    //添加到队列中
    [self.queue addOperation:op];
}

-(void)cancelLastOP:(NSURL *)lastURL{
    
    [[self.cacheOp objectForKey:lastURL] cancel];
}


@end
