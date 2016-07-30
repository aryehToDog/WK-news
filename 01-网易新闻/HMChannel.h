//
//  HMChannel.h
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/12/1.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMChannel : NSObject

//新闻的分类(频道)
@property (nonatomic,copy)NSString *tname;
@property (nonatomic,copy)NSString *tid;

//获取请求数据网址
@property (nonatomic,copy,readonly)NSString *urlString;


+ (instancetype)channelWithDict:(NSDictionary *)dict;

//返回数组懒加载
+ (NSArray *)channelWithArray;

@end
