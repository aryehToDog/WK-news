//
//  HMChannelLabel.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/12/1.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//
#define kBIGFONT 18
#define kSMALLFONT 14
#import "HMChannelLabel.h"

@implementation HMChannelLabel

+ (instancetype)channelLabelWithTName:(NSString *)tname{

    HMChannelLabel *lbl = [self new];
    lbl.text = tname;
    lbl.textAlignment = NSTextAlignmentCenter;

    //设置lbl大小
    lbl.font = [UIFont systemFontOfSize:kBIGFONT];
    
    [lbl sizeToFit];
    
    //lbl默认大小
    lbl.font = [UIFont systemFontOfSize:kSMALLFONT];
    
    return lbl;
}


- (void)setScale:(CGFloat)scale{

    CGFloat max = kBIGFONT * 1.0 / kSMALLFONT - 1;
    
    self.transform = CGAffineTransformMakeScale( max*scale+1, max*scale+1);
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];

}


@end
