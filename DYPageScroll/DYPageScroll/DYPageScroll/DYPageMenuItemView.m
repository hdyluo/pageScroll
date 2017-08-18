//
//  DYPageMenuItemView.m
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import "DYPageMenuItemView.h"
#import "Masonry.h"

@interface DYPageMenuItemView ()

@property (nonatomic,strong) UIButton * btn;

@end

@implementation DYPageMenuItemView

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        [self addSubview:self.btn];
        [self.btn setTitle:title forState:UIControlStateNormal];
        [self _layout];
    }
    return self;
}

- (void)_layout{
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)btnClicked:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(didClickedItme:)]) {
        [self.delegate didClickedItme:self.tag];
    }
}

#pragma mark - btn

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
