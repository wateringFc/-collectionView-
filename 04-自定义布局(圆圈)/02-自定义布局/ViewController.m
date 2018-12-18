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
#import "XMGCircleLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *imageNames;
/** 提示label */
@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

static NSString * const XMGPhotoId = @"photo";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    
    // 创建布局
    XMGCircleLayout *layout = [[XMGCircleLayout alloc] init];
    // 创建CollectionView
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 300;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
        // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:XMGPhotoId];
}

#pragma mark- lazy
- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%d", i + 1]];
        }
    }
    return _imageNames;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 35)];
        _label.text = @"点击屏幕切换布局";
        _label.textColor = [UIColor darkGrayColor];
        _label.font = [UIFont boldSystemFontOfSize:20];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

#pragma mark- 点击屏幕切换布局
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[XMGLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[XMGCircleLayout alloc] init] animated:YES];
    } else {
        XMGLineLayout *layout = [[XMGLineLayout alloc] init];
        layout.itemSize = CGSizeMake(150, 150);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGPhotoId forIndexPath:indexPath];
    cell.imageName = self.imageNames[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除点击当前itme
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
//    NSLog(@"%zd",indexPath.item);
}
@end
