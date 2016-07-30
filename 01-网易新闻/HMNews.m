//
//  HMNews.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMNews.h"
#import "HMNetworkTools.h"
@implementation HMNews

+ (instancetype)newsWithDict:(NSDictionary *)dict{

    HMNews *news = [HMNews new];
    
    [news setValuesForKeysWithDictionary:dict];

    return news;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

//发送异步请求获取数据
+ (void)newsWithurlString:(NSString *)urlString Sucess:(void(^)(NSArray *array))sucessBlock error:(void(^)())errorBlock{

    [[HMNetworkTools sharedNetworkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        //获取KEY
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        
        //获取数组
        NSArray *array = responseObject[rootKey];
        
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
        
        //遍历数组获取模型
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HMNews *model = [HMNews newsWithDict:obj];
            
            [mArray addObject:model];
            
        }];
        
        if (sucessBlock) {
            
            sucessBlock(mArray.copy);
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        if (errorBlock) {
        
            errorBlock();
        }
        
    }];

}



@end
