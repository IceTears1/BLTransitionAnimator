//
//  LeftVC.m
//  翻页效果
//
//  Created by 冰泪 on 2017/6/20.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "LeftVC.h"

@interface LeftVC ()

@end

@implementation LeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 400, 60, 30)];
//    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"Menu" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    //    [self.view addSubview:btn];
    
    
}

-(void)aaa{
  
   [self.navigationController dismissViewControllerAnimated:YES completion:^{
       
   }];
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
