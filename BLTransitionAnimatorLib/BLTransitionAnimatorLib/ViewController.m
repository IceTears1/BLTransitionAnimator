//
//  ViewController.m
//  翻页效果
//
//  Created by 冰泪 on 2017/6/16.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "ViewController.h"
#import "PushVC.h"
#import "PresentVC.h"
#import "TarBarMainVC.h"

#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)

#define GetStoryboardVC(storyBoardName,vcName) [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:vcName]
@interface ViewController ()
{

    NSArray *dataSource;
    bool isPush;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"转场动画";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]]; // 设置导航栏背景颜色
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //    [self.view addSubview:btn];
    
 
    dataSource = @[@"present 跳转",@"push 跳转",@"tabbar切换"];

    

}


#pragma mark tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return dataSource.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"BgCell";
    UITableViewCell *bgCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (bgCell == nil) {
        bgCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
   

    bgCell.textLabel.text = dataSource[indexPath.row];

    return bgCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


            switch (indexPath.row) {
                case 0:{
                    
                    PresentVC *vc = GetStoryboardVC(@"Present", @"PresentVC");
                    vc.title = @"present ";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:{
                    PushVC *vc = GetStoryboardVC(@"Push", @"PushVC");
                    vc.title = @"push ";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:{
                    TarBarMainVC *vc = [[TarBarMainVC alloc]init];
                    
                    [self presentViewController:vc animated:YES completion:^{
                        
                    }];
                }
                    break;
            
                    
                default:
                    break;
            }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
