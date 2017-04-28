//
//  DKDownloadOpManager.h
//  01-仿SD框架
//
//  Created by doublek on 2017/3/3.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKDownloadOpManager : NSObject

//单例类
+(instancetype)shareManager;

-(void)managerWithURL:(NSURL *)url andSuccesBlock:(void (^)(UIImage *img))bk;


-(void)cancelLastOP:(NSURL *)lastURL;

@end
