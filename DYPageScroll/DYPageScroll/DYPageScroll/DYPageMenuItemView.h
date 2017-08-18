//
//  DYPageMenuItemView.h
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DYPageMenuItemDelegate <NSObject>

- (void)didClickedItme:(NSInteger)tag;

@end

@interface DYPageMenuItemView : UIView

- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic,weak) id<DYPageMenuItemDelegate> delegate;

@end
