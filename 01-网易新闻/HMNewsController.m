//
//  HMNewsController.m
//  01-网易新闻
//
//  Created by 阿拉斯加的狗 on 15/11/30.
//  Copyright © 2015年 阿拉斯加的🐶. All rights reserved.
//

#import "HMNewsController.h"
#import "HMNews.h"
#import "HMNewsCell.h"
@interface HMNewsController ()

//定义一个属性
@property (nonatomic,strong)NSArray *array;

@end

@implementation HMNewsController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)setUrlString:(NSString *)urlString{

    //防止cell重用问题
    self.array = nil;
    
    [HMNews newsWithurlString:urlString Sucess:^(NSArray *array) {
        //获取数据
        self.array = array;
    } error:^{
        NSLog(@"出错");
    }];



}


#pragma mark - 异步操作刷新数据
- (void)setArray:(NSArray *)array{

    _array = array;
    
    [self.tableView reloadData];

}

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //1.获取数据
    HMNews *news = self.array[indexPath.row];
    
    //2.创建cell
    HMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[HMNewsCell getReuseId:news]];

    cell.news = news;
    
    
    return cell;
    
}

#pragma mark - 判断cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //1.获取数据
    HMNews *news = self.array[indexPath.row];
    
    return [HMNewsCell getRowHeight:news];

}


@end
