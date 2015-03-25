//
//  UIDeviceInfomation.h
//  UIDevice
//
//  Created by 孙苏 on 15/3/25.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIDeviceInfomation : NSObject
+ (UIDeviceInfomation *) sharedUIDeviceInfomation;
- (NSString *) platform;
- (NSString *) platformString;
- (NSString*)getDeviceID;
- (NSString*)getDeviceVersion;
- (NSString*)getCurrentNetwork;
- (NSString*)getCurrentTime;
- (id)fetchSSIDInfo;
@end
