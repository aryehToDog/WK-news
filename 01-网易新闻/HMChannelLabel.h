//
//  HMChannelLabel.h
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/12/1.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMChannelLabel : UILabel

+ (instancetype)channelLabelWithTName:(NSString *)tname;

//定义一个缩放的比例
@property (nonatomic,assign)CGFloat scale;

@end
