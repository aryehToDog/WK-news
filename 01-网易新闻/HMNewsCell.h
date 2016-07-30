//
//  HMNewsCell.h
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMNews;
@interface HMNewsCell : UITableViewCell

//定义属性属性
@property (nonatomic,strong)HMNews *news;

//判断是否为大图cell
+ (NSString *)getReuseId:(HMNews *)news;

//判断行高
+ (CGFloat)getRowHeight:(HMNews *)news;
@end
