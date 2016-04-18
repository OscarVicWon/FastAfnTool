//
//  ViewController.m
//  FastAfnTools
//
//  Created by 王鹤竹 on 16/4/18.
//  Copyright © 2016年 Wanghezhu. All rights reserved.
//

#import "ViewController.h"
#import "NetWorkingTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // get请求的网址
    NSString *getTestUrlStr = @"http://api.map.baidu.com";
    
    [NetWorkingTool getWithURL:getTestUrlStr cookie:nil success:^(id responsObject) {
        NSLog(@"get success: %@",responsObject);
    } failure:^(NSError *error) {
        NSLog(@"get error: %@",error);
    }];
    
    
    
    // post请求的网址
    NSString *postTestUrlStr = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx";
    // post请求的body
    NSString *postTestBodyStr = @"date=20131129&startRecord=1&len=30&udid=1234567890&terminalType=Iphone&cid=213";
    
    [NetWorkingTool postWithURL:postTestUrlStr bodyStr: postTestBodyStr cookie:nil success:^(id responsObject) {
        NSLog(@"post success: %@", responsObject);
    } failure:^(NSError *error) {
        NSLog(@"post error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
