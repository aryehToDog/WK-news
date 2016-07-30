//
//  HMHomeCell.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/12/1.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMHomeCell.h"
#import "HMNewsController.h"

@interface HMHomeCell ()

@property (nonatomic,strong)HMNewsController *newsController;

@end

@implementation HMHomeCell

//获取数据
- (void)awakeFromNib{

    [super awakeFromNib];

    //创建控制器加载View
    UIStoryboard *sb= [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    self.newsController = [sb instantiateInitialViewController];
    
    [self.contentView addSubview:self.newsController.view];

}


//设置view的大小
- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.newsController.view.frame = self.bounds;
    
}

- (void)setUrlString:(NSString *)urlString{

    self.newsController.urlString = urlString;

}

@end
