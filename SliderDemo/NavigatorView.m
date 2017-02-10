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
    UIColor *_lineViewColor;
    CGFloat _lineHeight;
    CGFloat _btnSpace;
    CGFloat _btnLeftSpace;
    NSInteger _sliderSelected;
    CGFloat _totalWidth;
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
        _lineViewColor = [UIColor orangeColor];
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = _lineViewColor;
        _lineHeight = 2.0;
        _btnSpace = 20;
        _btnLeftSpace = 20;
        _totalWidth = 0;
        _sliderSelected = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self addBtn];
    [self resetItemsProperty];
}

#pragma mark - setter
- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    [self creatItems];
    [self addBtn];
}

- (void)setTextNormalFont:(UIFont *)textNormalFont{
    _normalFont = textNormalFont;
}

- (void)setTextSeletedFont:(UIFont *)textSeletedFont{
    _selectedFont = textSeletedFont;
}

- (void)setTextNormalColor:(UIColor *)textNormalColor{
    _normalColor = textNormalColor;
}

- (void)setTextSeletedColor:(UIColor *)textSeletedColor{
    _selectedColor = textSeletedColor;
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineViewColor = lineColor;
}

- (void)setLineViewHeight:(CGFloat)lineViewHeight{
    _lineHeight = lineViewHeight;
}

- (void)setItemSpace:(CGFloat)itemSpace{
    _btnSpace = itemSpace;
}

- (void)setItemLeftSpace:(CGFloat)itemLeftSpace{
    _btnLeftSpace = itemLeftSpace;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _sliderSelected = selectedIndex;
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

- (void)resetItemsProperty{
    for (UIButton *btn in _btnArr) {
        [btn setTitleColor:_normalColor forState:(UIControlStateNormal)];
        [btn setTitleColor:_selectedColor forState:(UIControlStateSelected)];
        btn.titleLabel.font = _normalFont;
        btn.backgroundColor = [UIColor clearColor];
    }
    _lineView.backgroundColor = _lineViewColor;
}

- (void)addBtn{
    NSInteger index = 0;
    for (UIButton *btn in _btnArr) {
        CGFloat width = [self returnTitleWidthWithTitle:[btn titleForState:(UIControlStateNormal)]];
        btn.frame = CGRectMake((width + _btnSpace) * index + _btnLeftSpace, 0, width, self.bounds.size.height - _lineHeight);
        if (index == _sliderSelected) {
            btn.selected = YES;
            [self resetSelectedIndexWithIndex:_sliderSelected];
            _lineView.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y + btn.bounds.size.height, btn.bounds.size.width, _lineHeight);
            if (![self.subviews containsObject:_lineView]) {
                [self addSubview:_lineView];
            }
        }
        if (![self.subviews containsObject:btn]) {
            [self addSubview:btn];
        }
        index += 1;
    }
    UIButton *btn = [_btnArr lastObject];
    _totalWidth = btn.frame.origin.x + btn.bounds.size.width;
}

- (void)setLineTargetX:(CGFloat)lineTargetX{
    [self changeLineViewFrameWithX:lineTargetX lineWidth:_lineView.bounds.size.width];
}

- (void)scrollerDidScrollerWithRate:(CGFloat)rate{
    CGFloat targetX = rate * _totalWidth;
    [self changeLineViewFrameWithX:targetX + _btnLeftSpace lineWidth:_lineView.bounds.size.width];
}

- (CGFloat)returnTitleWidthWithTitle:(NSString *)title{
    CGFloat itemWidth = 0.0f;
    NSDictionary *dic = [NSDictionary dictionaryWithObject:_selectedFont forKey:NSFontAttributeName];
    itemWidth = [title boundingRectWithSize:CGSizeMake(0, self.bounds.size.height - _lineHeight) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size.width;
    return itemWidth;
}
#pragma mark - action
- (void)itemClickAction:(UIButton *)btn{
    [self resetSelectedIndexWithIndex:btn.tag - itemTagBase];
    CGFloat target = [_btnArr[btn.tag - itemTagBase] frame].origin.x;
    [self animationChangeLineViewFrameWithTargetX:target lineWith:[_btnArr[btn.tag - itemTagBase] frame].size.width];
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

- (void)changeLineViewFrameWithX:(CGFloat)targetX lineWidth:(CGFloat)width{
    _lineView.frame = CGRectMake(targetX, _lineView.frame.origin.y, width, _lineView.bounds.size.height);
}

- (void)animationChangeLineViewFrameWithTargetX:(CGFloat)targetX lineWith:(CGFloat)width{
    [UIView animateWithDuration:0.5 animations:^{
        [self changeLineViewFrameWithX:targetX+_btnLeftSpace lineWidth:width];
    }];
}

#pragma mark - init

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 */

@end
