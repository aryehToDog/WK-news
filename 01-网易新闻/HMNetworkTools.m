//
//  HMNetworkTools.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMNetworkTools.h"

@implementation HMNetworkTools

+ (instancetype)sharedNetworkTools{

    static HMNetworkTools *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //配置超时时长
        config.timeoutIntervalForRequest = 30;

        instance = [[self alloc]initWithBaseURL:baseURL sessionConfiguration:config];
    });
    
    //设置转换模式
    instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];


    return instance;
}



@end
