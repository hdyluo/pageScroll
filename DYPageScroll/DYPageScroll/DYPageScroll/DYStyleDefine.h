//
//  DYStyleDefine.h
//  DYFramework
//
//  Created by 黄德玉 on 2017/8/7.
//  Copyright © 2017年 Dorin Huang. All rights reserved.
//

#ifndef DYStyleDefine_h
#define DYStyleDefine_h


#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define RGBCOLOR(r, g, b) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : 1]

#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : (a)]

// 一个像素
#define onePix (1.0 / [UIScreen mainScreen].scale)

// pix转化为point
#define PixToPoint(pixValue) ceil((pixValue) / 2.0 * __FitWithScale_For_375)

//屏幕适配系数比例
#define __FitWidthScale_FOR_414  (SCREEN_WIDTH / 414.0f)

#define __FitWithScale_For_375 (SCREEN_WIDTH / 375.0f)


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NAVIGATION_HEIGHT 64

#define TABBAR_HEIGHT 49

#define STATUSBAR_HEIGHT 20

#define DEFAULT_LEFT_MARGIN PixToPoint(24)


#define COLOR_NAV_BACK RGBCOLOR(237,80,29)
#define COLOR_DEFALUT_FONT RGBCOLOR(100,100,100)
#define COLOR_DEFALUT_LINE [[UIColor lightGrayColor] colorWithAlphaComponent:.5]

#endif /* DYStyleDefine_h */
