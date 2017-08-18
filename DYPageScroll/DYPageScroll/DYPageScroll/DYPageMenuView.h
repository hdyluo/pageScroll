//
//  DYPageMenuView.h
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYPageMenuView : UIScrollView

- (instancetype)initWithTitles:(NSArray *)titles;

- (void)updateProgressWithOffset:(CGFloat)offset andIndex:(NSInteger) index;

@property (nonatomic,copy) void(^didClickedItem)(NSInteger index);
@end
