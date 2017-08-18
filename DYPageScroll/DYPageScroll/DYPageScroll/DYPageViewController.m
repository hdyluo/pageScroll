//
//  DYPageViewController.m
//  DiaoDiao
//
//  Created by 黄德玉 on 2017/8/17.
//  Copyright © 2017年 none. All rights reserved.
//

#import "DYPageViewController.h"
#import "DYPageContentViewController.h"
#import "DYPageMenuView.h"
#import "DYStyleDefine.h"
#import "DYSystemDefine.h"

@interface DYPageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    
}

@property (nonatomic,strong) UIPageViewController * subPageVC;
@property (nonatomic,strong) NSArray<DYPageContentViewController *> * vcs;
@property (nonatomic,assign) NSInteger currentTag;
@property (nonatomic,assign) NSInteger targetTag;
@property (nonatomic,strong) DYPageMenuView * menuView;


@end

@implementation DYPageViewController

- (instancetype)initWithVCS:(NSArray *)VCS{
    if (self = [super init]) {
        self.vcs = VCS;
        WS(weakSelf);
        [self.vcs enumerateObjectsUsingBlock:^(DYPageContentViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.vTag = idx;
            [weakSelf _addSubVCActionWithVC:obj];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _addChild];
    [self showIndex:0 animated:NO];
    [self.view addSubview:self.menuView];
    self.menuView.frame = CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, 50);
}


- (void)_addChild{
    [self addChildViewController:self.subPageVC];
    [self.view addSubview:self.subPageVC.view];
    self.subPageVC.view.frame = CGRectMake(0, NAVIGATION_HEIGHT + 50, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_HEIGHT - 50);
    [self _hackScroll];
    [self.subPageVC didMoveToParentViewController:self];
}

- (void)_hackScroll{
    UIScrollView * scrollView = [_subPageVC valueForKey:@"_scrollView"];        //私有属性
    scrollView.delegate = self;
    UIPanGestureRecognizer * fakerGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    fakerGes.delegate = self;
    [scrollView addGestureRecognizer:fakerGes];
    [scrollView.panGestureRecognizer requireGestureRecognizerToFail:fakerGes];
    [fakerGes requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
}

- (void)_addSubVCActionWithVC:(DYPageContentViewController *)vc{
    __weak typeof(vc) weakVC = vc;
    WS(weakSelf);
    vc.didLoadAction = ^{
        DLog(@"第%ld个视图执行viewDidLoad",(long)weakVC.vTag);
    };
    vc.didAppearAction = ^{
        DLog(@"第%ld个视图执行viewDidAppear",(long)weakVC.vTag);
        weakSelf.currentTag = weakVC.vTag;          //这个是必须的。
        weakSelf.targetTag = weakVC.vTag;
        UIScrollView * scrollView = [weakSelf.subPageVC valueForKey:@"_scrollView"];
        scrollView.scrollEnabled = YES;
        self.menuView.userInteractionEnabled = YES;
    };
    vc.didDisAppearAction = ^{
        DLog(@"第%ld个视图执行viewDidDisappera",(long)weakVC.vTag);
    };
    
    vc.drivePageChangeBlock = ^(DYPageChangeType type, UIViewController *vc, NSInteger tag) {
        switch (type) {
            case DYPageChangeTypeBack:
                [weakSelf.navigationController popViewControllerAnimated:vc];
                break;
            case DYPageChangeTypeForward:
                [weakSelf.navigationController pushViewController:vc animated:YES];
                break;
            case DYPageChangeTypeCurrentType:
                if (weakVC.vTag > tag) {
                    [weakSelf.subPageVC setViewControllers:@[self.vcs[tag]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
                }else{
                    [weakSelf.subPageVC setViewControllers:@[self.vcs[tag]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                }
                break;
            default:
                break;
        }
    };
}

- (void)showIndex:(NSInteger)index animated:(BOOL)anaimated{
    self.targetTag = index;
    if (_vcs.count > index) {
        if (self.currentTag  < index) {
            [self.subPageVC setViewControllers:@[self.vcs[index]] direction:UIPageViewControllerNavigationDirectionForward animated:anaimated completion:nil];
        }else{
            [self.subPageVC setViewControllers:@[self.vcs[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:anaimated completion:nil];
        }
    }
}
#pragma mark - pangesture

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if (self.currentTag == 0 && [gestureRecognizer translationInView:gestureRecognizer.view].x > 0) {
        return YES;
    }
    if (self.currentTag == self.vcs.count - 1 &&  [gestureRecognizer translationInView:gestureRecognizer.view].x < 0) {
        return YES;
    }
    return NO;
}

-(void)panGestureAction:(UIPanGestureRecognizer *)ges{
    
}


#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    self.menuView.userInteractionEnabled = NO;
    CGFloat currentOffset = scrollView.contentOffset.x;
    NSInteger multiplying = labs(self.targetTag - self.currentTag);
    multiplying = multiplying != 0 ? multiplying:1;
    if (currentOffset > SCREEN_WIDTH) { //向右
        CGFloat offset = (currentOffset - SCREEN_WIDTH) / self.vcs.count * multiplying;
        [self.menuView updateProgressWithOffset:offset andIndex:self.currentTag];
        
        if (self.currentTag == self.vcs.count - 1) {                                        //滑到边缘会有弹簧效果虽然被scrollView新添加的手势给禁止掉，但是可能会随机出现，所以添加这个条件
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        }
    }else{
        CGFloat offset = (SCREEN_WIDTH - currentOffset) / self.vcs.count * multiplying;
        [self.menuView updateProgressWithOffset:-offset andIndex:self.currentTag];
        if (self.currentTag == 0) {
            [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        }
    }
}



#pragma mark - page delegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    DYPageContentViewController * currentVC = (DYPageContentViewController *)viewController;
    NSInteger tag = currentVC.vTag;
    if (tag == 0) {
        return nil;
    }
    return self.vcs[tag - 1];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    DYPageContentViewController * currentVC = (DYPageContentViewController *)viewController;
    NSInteger tag = currentVC.vTag;
    if (tag == self.vcs.count - 1) {
        return nil;
    }
    return self.vcs[tag + 1];
}

#pragma mark - 初始化

-(UIPageViewController *)subPageVC{
    if (!_subPageVC) {
        _subPageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _subPageVC.delegate = self;
        _subPageVC.dataSource = self;
    }
    return  _subPageVC;
}

- (DYPageMenuView *)menuView{
    if (!_menuView) {
        NSMutableArray * arr = [NSMutableArray array];
        [self.vcs enumerateObjectsUsingBlock:^(DYPageContentViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:obj.title];
        }];
        _menuView = [[DYPageMenuView alloc] initWithTitles:arr];
        WS(weakSelf)
        __weak DYPageMenuView *  weakMenu = _menuView;
        _menuView.didClickedItem = ^(NSInteger index) {
            if (index == weakSelf.currentTag) {
                return ;
            }
            
            UIScrollView * scrollView = [weakSelf.subPageVC valueForKey:@"_scrollView"];
            if (scrollView.isTracking || scrollView.isDragging) {
                return;
            }
            weakMenu.userInteractionEnabled = NO;
            [weakSelf showIndex:index animated:YES];
            scrollView.scrollEnabled = NO;
        };
    }
    return _menuView;
}

@end
