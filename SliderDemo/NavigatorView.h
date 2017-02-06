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
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, copy) SelectAction selectAction;
//@property (nonatomic, assign) CGFloat lineTargetX;

- (void)scrollerDidScrollerWithRate:(CGFloat)rate;
- (void)resetSelectedIndexWithIndex:(NSInteger)index;
@end
