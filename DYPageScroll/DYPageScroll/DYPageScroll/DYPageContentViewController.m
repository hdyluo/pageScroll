//
//  DYPageContentViewController.m
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import "DYPageContentViewController.h"
#import "DYStyleDefine.h"
#import "DYSystemDefine.h"

@interface DYPageContentViewController ()

@end

@implementation DYPageContentViewController

- (void)dealloc{
    DLog(@"%@释放", NSStringFromClass([self class]));
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.didLoadAction) {
        self.didLoadAction();
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.didAppearAction) {
        self.didAppearAction();
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.didDisAppearAction) {
        self.didDisAppearAction();
    }
}




@end
