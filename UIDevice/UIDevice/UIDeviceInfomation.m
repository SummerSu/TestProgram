//
//  UIDeviceInfomation.m
//  UIDevice
//
//  Created by 孙苏 on 15/3/25.
//  Copyright (c) 2015年 sunsu. All rights reserved.
//

#import "UIDeviceInfomation.h"

// ASIdentifierManager
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>
#import <UIKit/UIDevice.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@import CoreTelephony.CTTelephonyNetworkInfo;


@implementation UIDeviceInfomation
static UIDeviceInfomation *sharedUIDeviceInfomation = nil;

+(UIDeviceInfomation*)sharedUIDeviceInfomation{
    if ([UIDeviceInfomation isSubclassOfClass:[UIDeviceInfomation class]]) {
        
        if (sharedUIDeviceInfomation == nil) {
            sharedUIDeviceInfomation = [[UIDeviceInfomation alloc]init];
            return sharedUIDeviceInfomation;
        }
    }
    return sharedUIDeviceInfomation;
}

- (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

//获取设备型号
- (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (CDMA)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (CDMA)";
    
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}

//获取设备ID
- (NSString*)getDeviceID{
    UIDevice * device = [UIDevice currentDevice];
    //NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    
    if ([device respondsToSelector:@selector(identifierForVendor)]) {
        return device.identifierForVendor.UUIDString;
    }
    return @"DeviceID is Unknow";
}

//获取设备的版本号
- (NSString*)getDeviceVersion{
    NSString * version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    return version;
}

//获取设备支的当前语言
- (NSString*)getDeviceLanguage{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

//获取设备当前的时间
- (NSString*)getCurrentTime{

    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd,hh:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}
/*
 
 * 获取当前网络
 *  http://www.tuicool.com/articles/AFrAJr
 
*/

-(NSString*)getCurrentNetwork{
    CTTelephonyNetworkInfo *currentNetworkInfo = [[CTTelephonyNetworkInfo alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioAccessChanged) name:
     CTRadioAccessTechnologyDidChangeNotification object:nil];
    //NSLog(@ "Initial cell connection: %@" , currentNetworkInfo.currentRadioAccessTechnology);
    NSString * cn = [NSString stringWithFormat:@"%@",currentNetworkInfo.currentRadioAccessTechnology];
    return cn;
}

-( void )radioAccessChanged {
    NSLog(@ "Now you're connected via %@" , [[CTTelephonyNetworkInfo alloc]init].currentRadioAccessTechnology);
}

//获取WiFi列表
- (id)fetchSSIDInfo{
    /*
    *check  ssid info
    NSDictionary *ifs = [BaseFunction fetchSSIDInfo];
    NSString *ssid = [[ifs objectForKey:@"SSID"] lowercaseString];
    */
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return info;
}





@end
