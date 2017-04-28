//
//  ViewController.m
//  01-仿SD框架
//
//  Created by doublek on 2017/3/3.
//  Copyright © 2017年 DoubleK. All rights reserved.
//

#import "ViewController.h"
#import "DKDownloaderOP.h"
#import "YYModel.h"
#import "DkModel.h"
#import "DKDownloadOpManager.h"
#import "UIImageView+DKWebImage.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController{
    
    
    NSArray <DkModel *> *_modelList;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    int index = arc4random_uniform((int)_modelList.count);
    
    DkModel *model = _modelList[index];
    
    NSURL *url = [NSURL URLWithString:model.icon];

    [self.imageView dk_setImageWithURL:url];
    
}

-(void)loadData{
    
    
    //读取json文件
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"apps.json" withExtension:nil];

    //解析json数据
    id jsonData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingMutableContainers error:nil];
    
    
    //转换成模型
    _modelList = [NSArray yy_modelArrayWithClass:[DkModel class] json:jsonData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
