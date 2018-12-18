//
//  ViewController.m
//  01-瀑布流
//
//  Created by xiaomage on 15/8/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"
#import "XMGWaterflowLayout.h"
#import "XMGShop.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "XMGShopCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, XMGWaterflowLayoutDelegate>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController

static NSString * const XMGShopId = @"shop";

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setupRefresh];
}

/** 设置Layout */
- (void)setupLayout
{
    // 创建布局
    XMGWaterflowLayout *layout = [[XMGWaterflowLayout alloc] init];
    layout.delegate = self;
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGShopCell class]) bundle:nil] forCellWithReuseIdentifier:XMGShopId];
}

/** 刷新加载 */
- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.footer.hidden = YES;
}

/** 下拉刷新 */
- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [XMGShop objectArrayWithFilename:@"1.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        // 刷新数据
        [self.collectionView reloadData];
        // 结束刷新
        [self.collectionView.header endRefreshing];
    });
}

/** 上拉加载 */
- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [XMGShop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        // 刷新数据
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
    });
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGShopId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"当前点击了第 %zd 个itme",indexPath.item);
}

#pragma mark- 自定义<XMGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(XMGWaterflowLayout *)waterflowLayout heightForItmeAtIndex:(NSUInteger)index itmeWidth:(CGFloat)itmeWidth
{
    XMGShop *shop = self.shops[index];
    return itmeWidth * shop.h / shop.w;
}

// 行间距（默认返回 10）
- (CGFloat)rowMarginInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout
{
    return 10;
}

// 列数（默认返回 3列）
- (CGFloat)columnCountInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout
{
//    return (self.shops.count <= 50) ?  2 : 3;
    return 2;
}

// 内边距(默认返回(10, 10, 10, 10))
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 40, 10);
}


@end
