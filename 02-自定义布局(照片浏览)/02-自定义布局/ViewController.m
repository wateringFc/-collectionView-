//
//  ViewController.m
//  02-自定义布局
//
//  Created by xiaomage on 15/8/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "XMGLineLayout.h"
#import "XMGPhotoCell.h"

/*-------------------------------牛逼的旋转库---------------------------------*/
/*※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※*/
/*※※※※※※※※※※※※※※※https://github.com/nicklockwood/iCarousel※※※※※※※※※※※※※※※※※※*/
/*※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※*/
// https://github.com/hanhailong/tubatu-iCarousel 利用iCarousel实现高仿土巴兔装修风格


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@end

@implementation ViewController

static NSString * const XMGPhotoId = @"photo";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局
    XMGLineLayout *layout = [[XMGLineLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 150);
    
    // 创建CollectionView
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 200;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:XMGPhotoId];
    
    // 继承UICollectionViewLayout(最基础布局)
    // 继承UICollectionViewFlowLayout(流水布局,系统计算好的）
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGPhotoId forIndexPath:indexPath];
    
    cell.imageName = [NSString stringWithFormat:@"%zd", indexPath.item + 1];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
}
@end
