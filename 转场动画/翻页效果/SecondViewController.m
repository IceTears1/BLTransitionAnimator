//
//  SecondViewController.m
//  翻页效果
//
//  Created by 冰泪 on 2017/6/16.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "SecondViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]]; // 设置导航栏背景颜色
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回菜单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)aaa{
    if (self.isPush) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
   
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
