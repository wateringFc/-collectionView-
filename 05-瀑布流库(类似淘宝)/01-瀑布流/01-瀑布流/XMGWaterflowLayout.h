//
//  XMGWaterflowLayout.h
//  01-瀑布流
//
//  Created by xiaomage on 15/8/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGWaterflowLayout;
@protocol XMGWaterflowLayoutDelegate <NSObject>
// 必须实现方法
@required
/**
 *  根据外界传入的数据返回每个itme的高度
 *
 *  @param waterflowLayout 布局
 *  @param index           索引
 *  @param itmeWidth       itme宽度
 */
- (CGFloat)waterflowLayout:(XMGWaterflowLayout *)waterflowLayout heightForItmeAtIndex:(NSUInteger)index itmeWidth:(CGFloat)itmeWidth;

// 可选实现方法
@optional
/** 返回 多少 列 */
- (CGFloat)columnCountInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout;
/** 返回 列 间距 */
- (CGFloat)columnMarginInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout;
/** 返回 行 间距 */
- (CGFloat)rowMarginInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout;
/** 返回 边缘 间距 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout;

@end


// 瀑布流不需要继承 UICollectionViewFlowLayout(流水布局) 需要自己写
@interface XMGWaterflowLayout : UICollectionViewLayout

@property (weak, nonatomic) id<XMGWaterflowLayoutDelegate> delegate;



/**
 *🍉🍉继承自 UICollectionViewLayout 必须实现如下四个方法(详见.m)🍉🍉
 
 * - (void)prepareLayout;
 
 * - (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
 
 * - (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
 
 * - (CGSize)collectionViewContentSize;
 */


@end
