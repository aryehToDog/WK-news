//
//  HMHeadLine.h
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMHeadLine : NSObject

//定义属性
@property (nonatomic,copy)NSString *title;

@property (nonatomic,copy)NSString *imgsrc;


+ (instancetype)headlineWithDict:(NSDictionary *)dict;


//放松异步请求获取数据
+ (void)headlineWithSucess:(void(^)(NSArray *array))sucess error:(void(^)())error;

@end
