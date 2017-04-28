//
//  NSString+DKAddition.m
//  01-仿SD框架
//
//  Created by doublek on 2017/3/4.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import "NSString+DKAddition.h"

@implementation NSString (DKAddition)

-(instancetype)dk_getImgPath{
    
    //获取沙盒中缓存目录
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *fileName = [self lastPathComponent];
    
    return [cachesPath stringByAppendingString:fileName];
}


@end
