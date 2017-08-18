//
//  DYPageContentViewController.h
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DYPageChangeType) {
    DYPageChangeTypeForward = 0,        //通知父控制器，进入到下级页面
    DYPageChangeTypeBack,               //通知父控制器，回到上级页面
    DYPageChangeTypeCurrentType         //通知父控制器，来回切换子控制器
};

@interface DYPageContentViewController : UIViewController

@property (nonatomic,assign) NSInteger vTag;
@property (nonatomic,copy)   void (^drivePageChangeBlock)(DYPageChangeType type,UIViewController * vc,NSInteger tag);  //如果是进入或退出页面，tag值不用管。如果是子控制器之间来回切换，则vc可以为空，但是必须制定tag值。

@property (nonatomic,copy) void (^didAppearAction)();
@property (nonatomic,copy) void (^didDisAppearAction)();
@property (nonatomic,copy) void(^didLoadAction)();

@end
