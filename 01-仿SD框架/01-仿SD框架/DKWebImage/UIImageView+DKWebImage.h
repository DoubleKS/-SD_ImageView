//
//  UIImageView+DKWebImage.h
//  01-仿SD框架
//
//  Created by doublek on 2017/3/4.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DKWebImage)

//只会生成getter 和 setter方法的声明,其他什么都不会生成
@property(nonatomic,copy)NSURL *lastURL;

-(void)dk_setImageWithURL:(NSURL *)url;

-(void)dk_setImageWithURL:(NSURL *)url andPlaceHoldImg:(UIImage *)holdImg;


@end
