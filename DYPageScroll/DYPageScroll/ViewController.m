//
//  ViewController.m
//  DYPageScroll
//
//  Created by 黄德玉 on 2017/8/18.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ViewController.h"
#import "PageContentVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init{
    PageContentVC * vc0 = [[PageContentVC alloc] init];
    vc0.title = @"第一页";
    PageContentVC * vc1 = [[PageContentVC alloc] init];
    vc1.title = @"第二页";
    PageContentVC * vc2 = [[PageContentVC alloc] init];
    vc2.title = @"第三页";
    PageContentVC * vc3 = [[PageContentVC alloc] init];
    vc3.title = @"第四页";
    if (self = [super initWithVCS:@[vc0,vc1,vc2,vc3]]) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"页面容器";
    [self showIndex:0 animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
