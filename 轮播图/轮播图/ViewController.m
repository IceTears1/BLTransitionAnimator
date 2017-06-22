//
//  ViewController.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "ViewController.h"
#import "PartnerProjectVC.h"
#import "CustomPartnershipPageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btn1:(UIButton *)sender {
//    PartnershipProjectVC *vc = [[PartnershipProjectVC alloc]init];

    CustomPartnerPageController *vc = [[CustomPartnerPageController alloc]init];
       [self.navigationController  pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
