//
//  ViewController.m
//  Block
//
//  Created by YangJie on 2017/6/2.
//  Copyright © 2017年 YangJie. All rights reserved.
//

#import "ViewController.h"
#import "MMAFNetWorking.h"

@interface ViewController ()

/**
 node 建立的本地服务器
 */
@property (nonatomic,copy) NSString * url;
@property (nonatomic,strong) NSDictionary *dict;

/**
 封装的类
 */
@property (nonatomic,strong) MMAFNetWorking *MMAFNW;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _url = @"http://127.0.0.1:3000/";
    _MMAFNW = [MMAFNetWorking sharedMMAFNetWorking];
    _dict = @{@"111":@"333"};
}
- (IBAction)postClick:(UIButton *)sender {
    [_MMAFNW POST:_url parameters:_dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"成功成功====%@",dict);
    } failure:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable error) {
        NSLog(@"--------------error=%@",error);
    }];
}

- (IBAction)getClick:(UIButton *)sender {
    [_MMAFNW GET:_url parameters:_dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"成功成功====%@",dict);
    } failure:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable error) {
        NSLog(@"--------------error=%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
