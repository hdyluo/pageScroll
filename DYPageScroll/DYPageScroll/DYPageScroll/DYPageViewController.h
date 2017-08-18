//
//  DYPageViewController.h
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DYPageContentViewController;

@interface DYPageViewController : UIViewController

- (instancetype)initWithVCS:(NSArray<DYPageContentViewController *> *)VCS;

- (void)showIndex:(NSInteger)index animated:(BOOL)animated;





@end
