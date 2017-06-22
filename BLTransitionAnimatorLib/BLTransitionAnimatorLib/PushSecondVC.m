//
//  PushSecondVC.m
//  BLTransitionAnimatorLib
//
//  Created by 冰泪 on 2017/6/22.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "PushSecondVC.h"

@interface PushSecondVC ()

@end

@implementation PushSecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 375, 50)];
    lab.text = @"pushSecond";
    lab.textColor = [UIColor redColor];
    lab.font = [UIFont systemFontOfSize:30];
    lab.textAlignment  = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 400, 60, 30)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"菜单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;

    
}
- (void)aaa{
    
    [self.navigationController popViewControllerAnimated:YES];
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
