//
//  ViewController.m
//  SliderDemo
//
//  Created by cnlive-lsf on 2017/2/6.
//  Copyright © 2017年 cnlive-lsf. All rights reserved.
//

#import "ViewController.h"
#import "FDSlideBar.h"
#import "NavigatorView.h"

@interface ViewController ()<UIScrollViewDelegate>{
    NSArray *_colorArr;
}
@property (nonatomic, strong) NavigatorView *naviBar;
@property (nonatomic, strong) FDSlideBar *sliderBar;
@property (nonatomic, strong) UIScrollView *mainScrollerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    _colorArr = @[[UIColor grayColor], [UIColor greenColor], [UIColor yellowColor]];
    [super viewDidLoad];
    [self addViewToScrollerView];
    [self blockAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)blockAction{
    __block ViewController *blockSelf =self;
    self.naviBar.selectAction = ^(NSInteger index){
        [UIView animateWithDuration:0.5 animations:^{
            blockSelf.mainScrollerView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * index, 0);
        }];
    };
}

- (void)addViewToScrollerView{
    NSInteger index = 0;
    for (UIColor *color in _colorArr) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * index, 0, [UIScreen mainScreen].bounds.size.width, self.mainScrollerView.bounds.size.height)];
        view.backgroundColor = color;
        [self.mainScrollerView addSubview:view];
        index += 1;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollerView) {
        CGFloat rate = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width * _colorArr.count);
        [self.naviBar scrollerDidScrollerWithRate:rate];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    if(scrollView == self.mainScrollerView){
        NSInteger index = targetContentOffset->x / [UIScreen mainScreen].bounds.size.width;
        [self.naviBar resetSelectedIndexWithIndex:index];
    }
}

- (FDSlideBar *)sliderBar{
    if (!_sliderBar) {
        _sliderBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        _sliderBar.backgroundColor = [UIColor orangeColor];
        _sliderBar.itemsTitle = @[@"aaa", @"bbb", @"ccc"];
//        [self.view addSubview:_sliderBar];
    }
    return _sliderBar;
}

- (NavigatorView *)naviBar{
    if (!_naviBar) {
        _naviBar = [[NavigatorView alloc] init];
        _naviBar.frame = CGRectMake(50, 20, 240, 30);
        _naviBar.backgroundColor = [UIColor purpleColor];
        _naviBar.titleArr = @[@"aaa", @"bbb", @"ccc"];
        [self.view addSubview:_naviBar];
    }
    return _naviBar;
}

- (UIScrollView *)mainScrollerView{
    if (!_mainScrollerView) {
        _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.naviBar.frame.origin.y + self.naviBar.bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.naviBar.bounds.size.height)];
        _mainScrollerView.backgroundColor = [UIColor lightGrayColor];
        _mainScrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _colorArr.count, [UIScreen mainScreen].bounds.size.height - self.naviBar.bounds.size.height);
        _mainScrollerView.delegate = self;
        _mainScrollerView.pagingEnabled = YES;
        [self.view addSubview:_mainScrollerView];
    }
    return _mainScrollerView;
}
@end
