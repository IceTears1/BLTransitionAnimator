//
//  TarBarMainVC.m
//  翻页效果
//
//  Created by 冰泪 on 2017/6/20.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "TarBarMainVC.h"
#import "LeftVC.h"
#import "MiddleVC.h"
#import "RightVC.h"
#import "BLTransitionAnimator.h"


@interface TarBarMainVC ()<UITabBarControllerDelegate>

@end

@implementation TarBarMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LeftVC *leftVC = [LeftVC new];
    leftVC.title = @"左视图";
    leftVC.tabBarItem.image = [[UIImage imageNamed:@"tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *leftNav = [[UINavigationController alloc]initWithRootViewController:leftVC];
    
    
    
    RightVC *rightVC = [RightVC new];
    rightVC.title = @"右视图";
    
    rightVC.tabBarItem.image = [[UIImage imageNamed:@"tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *rightNav = [[UINavigationController alloc]initWithRootViewController:rightVC];
    
    
    
    
    
    MiddleVC *middleVC = [MiddleVC new];
    middleVC.title = @"中视图";
    middleVC.tabBarItem.image = [[UIImage imageNamed:@"tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *middleNav = [[UINavigationController alloc]initWithRootViewController:middleVC];
    
    
    NSArray *array = @[leftNav,middleNav,rightNav];
    self.viewControllers = array;
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
    //设置标签栏的颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    //设置标签栏风格(默认高度49)
    
    
    //设置初始状态选中的下标
    self.selectedIndex = 0;
    
    
    
    
    
    self.delegate = self;

    
}
- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    NSUInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSUInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    if (fromVCIndex!=toVCIndex) {
          return [[BLTabBarTransitionAnimator alloc]initWithTargetStyle:fromVCIndex>toVCIndex?BLTabBarSlidingDirectionLeft:BLTabBarSlidingDirectionRight];
    }else{
        return [[BLTabBarTransitionAnimator alloc]initWithTargetStyle:BLTabBarSlidingDirectionNone];
    }
  
}
//- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                               interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0){
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
