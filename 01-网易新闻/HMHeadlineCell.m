//
//  HMHeadlineCell.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMHeadlineCell.h"
#import "HMHeadLine.h"
#import <UIImageView+AFNetworking.h>
@interface HMHeadlineCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;

@property (weak, nonatomic) IBOutlet UILabel *titleView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation HMHeadlineCell


//从写headline的方法
- (void)setHeadline:(HMHeadLine *)headline{

    _headline = headline;
    
    //解决重用问题
    self.imgsrcView.image = nil;
    self.titleView.text = nil;
    
    //设置图片
    [self.imgsrcView setImageWithURL:[NSURL URLWithString:headline.imgsrc]];
    
    //设置标题
    self.titleView.text = headline.title;
    
    self.pageControl.currentPage = self.tag;

}


@end
