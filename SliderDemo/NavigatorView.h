//
//  NavigatorView.h
//  SliderDemo
//
//  Created by cnlive-lsf on 2017/2/6.
//  Copyright © 2017年 cnlive-lsf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectAction)(NSInteger index);

@interface NavigatorView : UIView
/**
 标题数组
 */
@property (nonatomic, strong) NSArray *titleArr;
/**
 标题正常颜色
 */
@property (nonatomic, strong) UIColor *textNormalColor;
/**
 标题选中颜色
 */
@property (nonatomic, strong) UIColor *textSeletedColor;
/**
 线的选中颜色
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
 标题正常字体大小
 */
@property (nonatomic, strong) UIFont *textNormalFont;
/**
 标题选中字体大小
 */
@property (nonatomic, strong) UIFont *textSeletedFont;
/**
 下划线的高度
 */
@property (nonatomic, assign) CGFloat lineViewHeight;
/**
 每个item之间的间距 （不包括最左边和左右边）
 */
@property (nonatomic, assign) CGFloat itemSpace;
/**
 最左边item距离边距的大小
 */
@property (nonatomic, assign) CGFloat itemLeftSpace;

/**
 index点击事件
 */
@property (nonatomic, copy) SelectAction selectAction;

/**
 选中的下标
 */
@property (nonatomic, assign) NSInteger selectedIndex;


/**
 scrollerView滑动 更改下划线位置
 
 @param rate 滑动比例
 */
- (void)scrollerDidScrollerWithRate:(CGFloat)rate;

/**
 滑动页面重新选中item
 
 @param index 选中的item index
 */
- (void)resetSelectedIndexWithIndex:(NSInteger)index;
@end
