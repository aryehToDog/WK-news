//
//  HMChannel.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/12/1.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMChannel.h"

@implementation HMChannel

+ (instancetype)channelWithDict:(NSDictionary *)dict{

    HMChannel *channel = [self new];
    
    [channel setValuesForKeysWithDictionary:dict];
    
    return channel;
    

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

//返回数组懒加载
+ (NSArray *)channelWithArray{

    //从本地加载数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //JSON的反序列化
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSArray *array = dict[@"tList"];
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    
    //遍历数据  字典转模型
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HMChannel *model = [HMChannel channelWithDict:obj];
        
        [mArray addObject:model];
        
    }];
    
    //对模型中的tid进行排序
    return [mArray sortedArrayUsingComparator:^NSComparisonResult(HMChannel *obj1, HMChannel *obj2) {
        
        return [obj1.tid compare:obj2.tid];
        
    }];

}

//获取网络地址
- (NSString *)urlString{

    return [NSString stringWithFormat:@"article/headline/%@/0-140.html",self.tid];

}


@end
