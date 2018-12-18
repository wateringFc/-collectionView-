//
//  XMGShop.h
//  06-瀑布流
//
//  Created by apple on 14-7-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGShop : NSObject
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat w;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat h;
/** 图片的地址 */
@property (nonatomic, copy) NSString *img;
/** 价格 */
@property (nonatomic, copy) NSString *price;
@end
