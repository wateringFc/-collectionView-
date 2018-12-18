//
//  XMGCircleLayout.m
//  02-自定义布局
//
//  Created by xiaomage on 15/8/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGCircleLayout.h"

@interface XMGCircleLayout()
/** 布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end

@implementation XMGCircleLayout

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self.attrsArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 这个方法需要返回indexPath位置对应cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    // 半径(确定最后圆的大小)
    CGFloat radius = 110;
    // 圆心(确定collectionView的圆心的位置)
    CGFloat oX = self.collectionView.frame.size.width * 0.5;
    CGFloat oY = self.collectionView.frame.size.height * 0.5;
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.size = CGSizeMake(50, 50);
    if (count == 1) {
        attrs.center = CGPointMake(oX, oY);
    } else {
        /*详情见文件内示例图*/
        // 当前自己的角度 =（360 / 个数）* 第几个【360 / 个数 得出平分后的角度】
        CGFloat angle = (2 * M_PI / count) * indexPath.item;
        // 当前自己的X = 圆心的X + 半径 * sin(自己的角度)
        CGFloat centerX = oX + radius * sin(angle);
        // 当前自己的Y = 圆心的Y + 半径 * cos(自己的角度)
        CGFloat centerY = oY + radius * cos(angle);
        
        attrs.center = CGPointMake(centerX, centerY);
    }
    
    return attrs;
}

@end
