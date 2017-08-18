//
//  PageContentVC.m
//  DYPageScroll
//
//  Created by 黄德玉 on 2017/8/18.
//  Copyright © 2017年 none. All rights reserved.
//

#import "PageContentVC.h"

@interface PageContentVC ()

@end

@implementation PageContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.vTag) {
        case 0:
            self.view.backgroundColor = [UIColor redColor];
            break;
        case 1:
            self.view.backgroundColor = [UIColor cyanColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor orangeColor];
            break;
        case 3:
            self.view.backgroundColor = [UIColor darkGrayColor];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
