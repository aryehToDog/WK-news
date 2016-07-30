//
//  HMImageLoopController.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMImageLoopController.h"
#import "HMHeadLine.h"
#import "HMHeadlineCell.h"
@interface HMImageLoopController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLaout;

//当前图片的索引
@property (nonatomic, assign) NSInteger currentIndex;

//声明一个属性
@property (nonatomic,strong)NSArray *array;

@end

@implementation HMImageLoopController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [HMHeadLine headlineWithSucess:^(NSArray *array) {
       
        self.array = array;
        
    } error:^{
        
        NSLog(@"请求数据失败");
        
    }];
    
    [self setCollectionViewStyle];
    
}

#pragma mark - 刷新数据
- (void)setArray:(NSArray *)array{

    _array = array;
    
    [self.collectionView reloadData];
    
    //永远显示第二个CELL
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}

- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];

    //设置cell的大小
    self.flowLaout.itemSize = self.collectionView.frame.size;

    
}

#pragma mark - 设置collectionView的样式
- (void)setCollectionViewStyle{

    
    //设置滚动方向
    self.flowLaout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.flowLaout.minimumInteritemSpacing = 0;
    self.flowLaout.minimumLineSpacing = 0;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;

}



#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    HMHeadlineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"headline" forIndexPath:indexPath];
    
    //在滚动过程中下一张图片的索引
    //当滚动的过程中item的值可能是 0 或者 2
    NSInteger index = (self.currentIndex + indexPath.item - 1 + self.array.count) % self.array.count;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.headline = self.array[index];
    
    cell.tag = index;
    
    return cell;
}
//collectionView的代理方法
//滚动停止之后，把cell换成第二个cell
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //计算下一张图片的索引 (+1  -1)
    //返回的值始终是 （0  2） - 1
    int offset = scrollView.contentOffset.x / scrollView.bounds.size.width - 1;
    self.currentIndex = (self.currentIndex + offset + self.array.count ) % self.array.count;
    
    
    //始终显示第二个cell
    //主队列的执行特点：先等待主线程上的代码都执行完毕，再执行队列中的任务
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    });
    
    
}

@end
