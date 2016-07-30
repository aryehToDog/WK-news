//
//  HMNewsCell.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMNewsCell.h"
#import "HMNews.h"
#import <UIImageView+AFNetworking.h>
@interface HMNewsCell ()

//声明图片,文字,摘要及回复数
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *digestView;
@property (weak, nonatomic) IBOutlet UILabel *replyCount;


@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextraViews;
@end

@implementation HMNewsCell

//从写news的set方法进行赋值
- (void)setNews:(HMNews *)news{

    _news = news;
    
    //获取图片,文字,摘要及回复数
    [self.imgsrcView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    self.titleView.text = news.title;
    self.digestView.text = news.digest;
    self.replyCount.text = [NSString stringWithFormat:@"回帖数:%d",news.replyCount.intValue];
    
    //获取数组中的照片
    [news.imgextra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //获取图片的路径
        NSString *imgsrc = obj[@"imgsrc"];
        
        UIImageView *imageView = self.imgextraViews[idx];
        
        [imageView setImageWithURL:[NSURL URLWithString:imgsrc]];
        
    }];

}


//判断是否为大图cell
+ (NSString *)getReuseId:(HMNews *)news{
    
    if (news.imgType) {
        //大图
        return @"news1";
    }else if(news.imgextra){
        //三张图
        return @"news2";
    }

    return @"news";
}


//判断行高
+ (CGFloat)getRowHeight:(HMNews *)news{
    
    if (news.imgType) {
        //大图
        return 200;
    }else if (news.imgextra){
        //三张图
        return 150;
    }
    
    return 80;
}

@end
