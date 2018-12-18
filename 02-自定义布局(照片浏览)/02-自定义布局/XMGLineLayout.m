//
//  XMGLineLayout.m
//  02-自定义布局
//
//  Created by xiaomage on 15/8/6.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGLineLayout.h"

@implementation XMGLineLayout

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

/** 关键方法
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 1.prepareLayout
 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/** 用来做布局的初始化操作（※※※不建议在init方法中进行布局的初始化操作※※※）*/
- (void)prepareLayout
{
    [super prepareLayout];
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置内边距(通过设置内边距 左右边距(就是显示范围)，这样才能显示最左最右的两个cell)
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

/** 注意点：※※
 UICollectionViewLayoutAttributes(布局属性);
 1.一个 cell 对应一个 UICollectionViewLayoutAttributes对象
 2.UICollectionViewLayoutAttributes对象 决定了 cell的frame
 */

/**
 * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 1.获得 父类(super) 已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 2.计算collectionView最中心点的x值 =（collectionView偏移的X值 + collectionView的一半）
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 3.遍历所有cell，在原有布局属性的基础上，进行微调（※※※缩放关键代码※※※）
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // cell的中心点x 和 collectionView最中心点的x值 的间距 （ABS绝对值->系统宏）
        CGFloat delta = ABS(attrs.center.x - centerX);
        
        // 根据间距值计算cell的缩放比例(距离collectionView中心点越远值越小,当 1 这个值越大，itme缩放值会变大，间隙变小）
        CGFloat scale = 1 - delta / self.collectionView.frame.size.width;
        
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
        
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得父类 (super) 已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值(※※※最终滑动停止的的x偏移量 + collectionView宽度的一半※※※)
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 存放最小的间距值(保证 minDelta 是最大值)
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // 挑出距离collectionview的中心点最近的cell。计算出cell的中心点和collectionView的中心点间距
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    // 修改原有的偏移量（让距离最近的cell中心点与collectionView中心点重合，让cell显示最大）
    proposedContentOffset.x += minDelta;
    
    return proposedContentOffset;
}

@end

/**
 1.cell的放大和缩小
 2.停止滚动时：cell的居中
 */
