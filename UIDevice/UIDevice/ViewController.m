//
//  ViewController.m
//  UIDevice
//
//  Created by 孙苏 on 15/3/25.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[[UIDeviceInfomation sharedUIDeviceInfomation]getDeviceID]);
    NSLog(@"%@",[[UIDeviceInfomation sharedUIDeviceInfomation]getDeviceVersion]);
    NSLog(@"%@",[[UIDeviceInfomation sharedUIDeviceInfomation]getCurrentTime]);
    NSLog(@"%@",[[UIDeviceInfomation sharedUIDeviceInfomation]getCurrentNetwork]);
    NSLog(@"%@",[[UIDeviceInfomation sharedUIDeviceInfomation]fetchSSIDInfo]);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
