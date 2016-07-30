//
//  HMHeadLine.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMHeadLine.h"
#import "HMNetworkTools.h"
@implementation HMHeadLine

+ (instancetype)headlineWithDict:(NSDictionary *)dict{

    HMHeadLine *headline = [self new];
    
    [headline setValuesForKeysWithDictionary:dict];
    
    return headline;

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}


//获取数据
+ (void)headlineWithSucess:(void (^)(NSArray *))sucess error:(void (^)())error{

    
    
    [[HMNetworkTools sharedNetworkTools] GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        //字典转模型获取数据
        //获取第一个KEY
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        NSArray *array = responseObject[rootKey];
        
        NSMutableArray *marray = [NSMutableArray arrayWithCapacity:4];
        
        //循环遍历获取模型
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HMHeadLine *model = [HMHeadLine headlineWithDict:obj];
            
            [marray addObject:model];
            
        }];
        
        if (sucess) {
            
            sucess(marray.copy);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (error) {
            
        }
        
    }];


}

@end
