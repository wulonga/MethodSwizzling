//
//  ViewController.m
//  关联方法
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 Gooou. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Limit.h"
#import "NSArray+CrashHandle.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn=[UIButton new];
    btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"btnTest" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setAcceptEventInterval:3];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    //下标越界测试代码
    NSArray *array=@[@0,@1,@2,@3];
    [array objectAtIndex:3];
    //本来要崩溃的
    [array objectAtIndex:4];
}
-(void)btnAction
{
    NSLog(@"btnAction is excuated");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
