//
//  HMNews.h
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNews : NSObject

//声明属性
@property (nonatomic,copy)NSString *imgsrc;
@property (nonatomic,copy)NSString *digest;
@property (nonatomic,copy)NSNumber *replyCount;
@property (nonatomic,copy)NSString *title;

//声明一个大图属性
@property (nonatomic,assign)BOOL imgType;

//声明三张图的属性
@property (nonatomic, copy) NSArray *imgextra;

//定义方法
+ (instancetype)newsWithDict:(NSDictionary *)dict;

//发送异步请求获取数据
+ (void)newsWithurlString:(NSString *)urlString Sucess:(void(^)(NSArray *array))sucessBlock error:(void(^)())errorBlock;

@end
