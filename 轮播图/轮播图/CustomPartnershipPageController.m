//
//  CustomPartnershipPageController.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/14.
//  Copyright © 2017年 冰泪. All rights reserved.

//合伙项目 分页
#import "CustomPartnershipPageController.h"
#import "PartnerProjectVC.h"
#import "MySubscribeVC.h"
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@interface CustomPartnerPageController ()

@end

@implementation CustomPartnerPageController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合伙项目";
    // Do any additional setup after loading the view.
}

- (instancetype)init {
    if (self = [super init]) {
        self.menuHeight = 40.0;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = DeviceMaxWidth/2;
        self.titleSizeNormal = 17;
        self.titleSizeSelected = 17;
        self.titleColorNormal = [UIColor grayColor];
        self.titleColorSelected = [UIColor redColor];
        self.pageAnimatable = YES;
      
    }
    return self;
}
- (NSArray *)titles {
    return @[@"查看合伙项目", @"我的认购"];
}
#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            PartnerProjectVC *vc = [[PartnerProjectVC alloc] init];
            return vc;
        }
            break;
        default: {
            MySubscribeVC *vc = [[MySubscribeVC alloc] init];
            return vc;
        }
            break;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

//- (void)pageController:(WMPageController *)pageController lazyLoadViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
//    NSLog(@"%@", info);
//}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
//    NSLog(@"%@", info);
}


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
