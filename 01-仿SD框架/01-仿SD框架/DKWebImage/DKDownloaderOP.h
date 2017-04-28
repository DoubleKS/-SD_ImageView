//
//  DKDownloaderOP.h
//  01-仿SD框架
//
//  Created by doublek on 2017/3/3.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKDownloaderOP : NSOperation


+(instancetype)wedUIImageOpWithURL:(NSURL *)url andWithSucceBlock:(void (^)(UIImage *))bk;

@end
