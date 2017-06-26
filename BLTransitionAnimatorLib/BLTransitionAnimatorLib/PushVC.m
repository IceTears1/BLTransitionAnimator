//
//  PushVC.m
//  BLTransitionAnimatorLib
//
//  Created by 冰泪 on 2017/6/22.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "PushVC.h"
#import "PushSecondVC.h"
#import "BLTransitionAnimator.h"


@interface PushVC ()
{
    NSArray *dataSourcePush;
    BLTransitionAnimatorStyle bl_Type;
}
@end

@implementation PushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dataSourcePush = @[@"top to bottom ",@"bottom to top",@"left to right",@"right to left",@"custom"];
//    self.navigationController.delegate = self;//push 跳转需要 遵循代理
}





#pragma mark tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataSourcePush.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"BgCell";
    UITableViewCell *bgCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (bgCell == nil) {
        bgCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    bgCell.textLabel.text = dataSourcePush[indexPath.row];
    
    return bgCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            bl_Type = BLTransitionAnimatorTop;
        }
            break;
        case 1:{
            bl_Type = BLTransitionAnimatorBottom;
        }
            break;
        case 2:{
            bl_Type = BLTransitionAnimatorLeft;
        }
            break;
        case 3:{
            bl_Type = BLTransitionAnimatorRight;
        }
            break;
        case 4:{
            bl_Type = BLTransitionAnimatorCustom;
        }
            break;
            
        default:
            break;
    }
  
    PushSecondVC *vc = [[PushSecondVC alloc]init];

    [self.navigationController BL_pushViewController:vc AnimatorStyle:bl_Type animated:YES];
    
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
