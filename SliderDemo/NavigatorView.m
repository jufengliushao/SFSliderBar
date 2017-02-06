//
//  NavigatorView.m
//  SliderDemo
//
//  Created by cnlive-lsf on 2017/2/6.
//  Copyright © 2017年 cnlive-lsf. All rights reserved.
//

#import "NavigatorView.h"

@interface NavigatorView(){
    NSMutableArray *_btnArr;
    UIView *_lineView;
    UIFont *_normalFont;
    UIFont *_selectedFont;
    UIColor *_normalColor;
    UIColor *_selectedColor;
    CGFloat _oldLineX;
}

@end

static long long itemTagBase = 11000;

@implementation NavigatorView
- (instancetype)init{
    if (self = [super init]) {
        _btnArr = [NSMutableArray arrayWithCapacity:0];
        _normalFont = [UIFont systemFontOfSize:14];
        _selectedFont = [UIFont systemFontOfSize:16];
        _normalColor = [UIColor whiteColor];
        _selectedColor = [UIColor orangeColor];
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = _selectedColor;
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    [self creatItems];
    [self addBtn];
}

#pragma mark - method
- (void)creatItems{
    for (NSString *title in self.titleArr) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateSelected];
        [btn setTitleColor:_normalColor forState:(UIControlStateNormal)];
        [btn setTitleColor:_selectedColor forState:(UIControlStateSelected)];
        btn.titleLabel.font = _normalFont;
        btn.backgroundColor = [UIColor clearColor];
        btn.selected = NO;
        btn.tag = _btnArr.count + itemTagBase;
        [btn addTarget:self action:@selector(itemClickAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_btnArr addObject:btn];
    }
}

- (void)addBtn{
    NSInteger index = 0;
    for (UIButton *btn in _btnArr) {
        btn.frame = CGRectMake(80 * index, 0, 80, self.bounds.size.height - 2);
        if (index == 0) {
            btn.selected = YES;
            _lineView.frame = CGRectMake(0, btn.frame.origin.y + btn.bounds.size.height, btn.bounds.size.width, 2);
            [self addSubview:_lineView];
        }
        [self addSubview:btn];
        index += 1;
    }
}

- (void)setLineTargetX:(CGFloat)lineTargetX{
    [self changeLineViewFrameWithX:lineTargetX];
}

- (void)scrollerDidScrollerWithRate:(CGFloat)rate{
    CGFloat targetX = rate * self.bounds.size.width;
    [self changeLineViewFrameWithX:targetX];
}
#pragma mark - action
- (void)itemClickAction:(UIButton *)btn{
    [self resetSelectedIndexWithIndex:btn.tag - itemTagBase];
    CGFloat target = [_btnArr[btn.tag - itemTagBase] frame].origin.x;
    [self animationChangeLineViewFrameWithTargetX:target];
    if (self.selectAction) {
        self.selectAction(btn.tag - itemTagBase);
    }
}

- (void)resetSelectedIndexWithIndex:(NSInteger)index{
    for (UIButton *btn in _btnArr) {
        btn.selected = NO;
        if (btn.tag - itemTagBase == index) {
            btn.selected = YES;
        }
    }
}

- (void)changeLineViewFrameWithX:(CGFloat)targetX{
    _lineView.frame = CGRectMake(targetX, _lineView.frame.origin.y, _lineView.bounds.size.width, _lineView.bounds.size.height);
}

- (void)animationChangeLineViewFrameWithTargetX:(CGFloat)targetX{
    [UIView animateWithDuration:0.5 animations:^{
        [self changeLineViewFrameWithX:targetX];
    }];
}

#pragma mark - init

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
