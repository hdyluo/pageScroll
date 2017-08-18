//
//  DYPageMenuView.m
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import "DYPageMenuView.h"
#import "DYPageMenuItemView.h"
#import "Masonry.h"
#import "DYStyleDefine.h"

@interface DYPageMenuView ()<DYPageMenuItemDelegate>

@property (nonatomic,strong) UIView * containerView;
@property (nonatomic,strong) NSMutableArray<DYPageMenuItemView *> * items;
@property (nonatomic,strong) UIView * bottomLine;
@property (nonatomic,strong) NSMutableArray<UIView *> * seperateLines;
@property (nonatomic,strong) UIView * progressLine;

@property (nonatomic,assign) NSInteger currentIndex;            //当前索引
@property (nonatomic,assign) CGFloat itemWidth;
@end

@implementation DYPageMenuView


- (instancetype)initWithTitles:(NSArray *)titles{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.containerView];
        [self addSubview:self.bottomLine];
        [self addSubview:self.progressLine];
        self.seperateLines = [NSMutableArray array];
        self.items = [NSMutableArray array];
        [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DYPageMenuItemView * item = [[DYPageMenuItemView alloc] initWithTitle:obj];
            item.tag = idx;
            item.delegate = self;
            [self.items addObject:item];
            [self.containerView addSubview:item];
            if (idx < titles.count - 1) {   //分割线比项目少一个
                UIView * lineV = [UIView new];
                lineV.backgroundColor = COLOR_DEFALUT_LINE;
                [self.seperateLines addObject:lineV];
                [self.containerView addSubview:lineV];
            }
        }];
        [self _layout];
    }
    return self;
}

- (void)_layout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(self);
    }];
    [self.items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.containerView);
        make.width.equalTo(@(SCREEN_WIDTH / self.items.count));
    }];
    [self.seperateLines mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.containerView).multipliedBy(.67);
        make.width.equalTo(@(onePix));
        make.centerY.equalTo(self.containerView);
    }];
    [self.items enumerateObjectsUsingBlock:^(DYPageMenuItemView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            if (idx == 0) {
                make.left.equalTo(self.containerView);
            }else{
                make.left.equalTo(self.items[idx - 1].mas_right);
            }
            if (idx == self.items.count - 1) {
                make.right.equalTo(self.containerView).priorityLow();
            }
        }];
        if (idx < self.items.count - 1) {
            [self.seperateLines[idx] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(obj.mas_right);
            }];
        }
        
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(onePix));
    }];
    [self.progressLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(@3);
        make.width.equalTo(self.items[0]);
        make.left.equalTo(self).offset((SCREEN_WIDTH / self.items.count) * 0);
    }];
}

- (void)updateProgressWithOffset:(CGFloat)offset andIndex:(NSInteger)index{
    [self.progressLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((SCREEN_WIDTH / self.items.count) * index + offset);
    }];
}

#pragma mark - delegate

- (void)didClickedItme:(NSInteger)tag{
    if (self.didClickedItem) {
        self.didClickedItem(tag);
    }
}

#pragma mark - 初始化

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = COLOR_DEFALUT_LINE;
    }
    return _bottomLine;
}

- (UIView *)progressLine{
    if (!_progressLine) {
        _progressLine = [UIView new];
        _progressLine.backgroundColor = [UIColor redColor];
    }
    return _progressLine;
}

@end
