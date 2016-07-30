//
//  HMHomeController.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/12/1.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMHomeController.h"
#import "HMChannel.h"
#import "HMChannelLabel.h"
#import "HMHomeCell.h"
@interface HMHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//声明一个数组用来保存数据
@property (nonatomic,strong)NSArray *channels;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *cooectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLaout;

//记录当前lbl的的索引
@property (nonatomic,assign)int currenIndex;
@end

@implementation HMHomeController

#pragma mark - 懒加载
- (NSArray *)channels{

    if (_channels == nil) {
        
        _channels = [HMChannel channelWithArray];
    }

    return _channels;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //创建分类
    [self loadChannels];
    
    //设置item的大小及collettionView的属性
    [self getCollectionView];
 
    
}

#pragma mark - 设置item的大小及collettionView的属性
- (void)getCollectionView{

    
    //设置间距
    self.flowLaout.minimumInteritemSpacing = 0;
    self.flowLaout.minimumLineSpacing = 0;
    self.flowLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置collectionView一些属性
    self.cooectionView.bounces = NO;
    //分页
    self.cooectionView.pagingEnabled = YES;
    //水平条
    self.cooectionView.showsHorizontalScrollIndicator = NO;



}


- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    //设置cell大小
    self.flowLaout.itemSize = self.cooectionView.frame.size;

}

#pragma mark - 创建频道中的分类
- (void)loadChannels{

    //不让控制器自动生成64的偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat marginX = 5;
    CGFloat x = marginX;
    CGFloat y = 0;
    CGFloat h = self.scrollView.bounds.size.height;
    
    //利用循环获取分类的名称
    for (HMChannel *channel in self.channels) {
        
        //自定义label获取数据
        HMChannelLabel *lbl = [HMChannelLabel channelLabelWithTName:channel.tname];
        
        //添加到scrollView中
        [self.scrollView addSubview:lbl];
        
        //设置frame  宽度就为字体本身的宽度
        lbl.frame = CGRectMake(x, y, lbl.bounds.size.width, h);
        
        x += lbl.bounds.size.width + marginX;
        
    }
    
    //scrollView滚动的范围
    self.scrollView.contentSize = CGSizeMake(x, h);
    //取消水平滑动条
    self.scrollView.showsHorizontalScrollIndicator = NO;

}

#pragma mark - 寻找滚动时候下一个lbl
//当collectionView滚动时候计算lbl的顺序
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //当前lbl
    HMChannelLabel *currentlbl = self.scrollView.subviews[self.currenIndex];

    //下一个lbl
    HMChannelLabel *nextlbl = nil;
    
    //遍历当前可见cell的索引
    for (NSIndexPath *indexPath in self.cooectionView.indexPathsForVisibleItems) {
        
        if (indexPath.item != self.currenIndex) {
            
            //就是下一个lbl
            nextlbl = self.scrollView.subviews[indexPath.item];
            break;
            
        }
        
        if (nextlbl == nil) {
            return;
        }
        
    }
    
    //获取滚动的比例
    CGFloat nextScale = ABS(scrollView.contentOffset.x / scrollView.bounds.size.width - self.currenIndex);
    CGFloat currentScale = 1- nextScale;
    
    currentlbl.scale = currentScale;
    nextlbl.scale = nextScale;
    
    //计算currentlbl的位置
    self.currenIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
}

#pragma mark - 当滚动结束后计算currentlbl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //居中显示当前显示的标签
    HMChannelLabel *label = self.scrollView.subviews[self.currenIndex];
    CGFloat offset = label.center.x - self.scrollView.bounds.size.width * 0.5;
    CGFloat maxOffset = self.scrollView.contentSize.width - label.bounds.size.width - self.scrollView.bounds.size.width;
    
    if (offset < 0) {
        offset = 0;
    } else if (offset > maxOffset) {
        offset = maxOffset + label.bounds.size.width;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];

    

}



#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    //获取数据
    HMChannel *channel = self.channels[indexPath.item];
    
    //创建cell
    HMHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"home" forIndexPath:indexPath];

    cell.urlString = channel.urlString;
    
    return cell;



}

@end
