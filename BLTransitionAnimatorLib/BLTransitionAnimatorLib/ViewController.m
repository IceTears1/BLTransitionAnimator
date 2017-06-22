//
//  ViewController.m
//  翻页效果
//
//  Created by 冰泪 on 2017/6/16.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "BLTransitionAnimator.h"
#import "TarBarMainVC.h"

#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@interface ViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
{
    NSArray *dataSourcePresent;
    NSArray *dataSourcePush;
    BLTransitionAnimatorStyle bl_Type;
    bool isPush;
    BLTransitionInteraction *bl_Interaction;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]]; // 设置导航栏背景颜色
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 400, 30, 30)];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    //    [self.view addSubview:btn];
    
    dataSourcePresent = @[@"top to bottom ",@"bottom to top",@"left to right",@"right to left"];
    
    dataSourcePush = @[@"top to bottom ",@"bottom to top",@"left to right",@"right to left"];
    
    
    
    self.navigationController.delegate = self;//push 跳转需要 遵循代理
    
    //初始化手势过渡的代理
    bl_Interaction = [BLTransitionInteraction interactiveTransitionWithTransitionType:BLTransitionTypePresent GestureDirection:BLGestureDirectionRight];
    //    typeof(self)weakSelf = self;
    //    bl_Interaction.presentConifg = ^(){
    //        [weakSelf present];
    //    };
    //给当前控制器的视图添加手势
    [bl_Interaction addPanGestureForViewController:self.navigationController];
    
    
}

-(void)aaa{
    SecondViewController *two = [[SecondViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:two];
    nav.transitioningDelegate = self;
    //    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate   //模态跳转  的代理

//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the presentation of the incoming view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  presentation animation should be used.
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[BLPresentTransitionAnimator alloc] initWithTargetStyle:bl_Type];
    
}
//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the dismissal of the presented view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  dismissal animation should be used.
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[BLPresentTransitionAnimator alloc] initWithTargetStyle:bl_Type];
}
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return bl_Interaction;
}
//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
//
//
//    return bl_Interaction.interation ? bl_Interaction : nil;
//
//}
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return bl_Interaction.interation ? bl_Interaction : nil;
}


#pragma mark -
#pragma mark UINavigationControllerDelegate   //push跳转   的代理

//| ----------------------------------------------------------------------------
//  The navigation controller tries to invoke this method on its delegate to
//  retrieve an animator object to be used for animating the transition to the
//  incoming view controller.  Your implementation is expected to return an
//  object that conforms to the UIViewControllerAnimatedTransitioning protocol,
//  or nil if the transition should use the navigation controller's default
//  push/pop animation.
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    return [[BLPushTransitionAnimator alloc]initWithTargetStyle:bl_Type];
}






#pragma mark tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return dataSourcePresent.count;
    }else if(section == 1){
        return dataSourcePush.count;
    }else{
        return 1;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"BgCell";
    UITableViewCell *bgCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (bgCell == nil) {
        bgCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if(indexPath.section == 0){
        bgCell.textLabel.text = dataSourcePresent[indexPath.row];
    }else if(indexPath.section == 1){
        bgCell.textLabel.text = dataSourcePush[indexPath.row];
    }else{
        bgCell.textLabel.text = @"tabBar转场";
    }
    return bgCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     dataSourcePresent = @[@"top to bottom ",@"bottom to top",@"left to right",@"right to left"];
     
     dataSourcePush = @[@"top to bottom ",@"bottom to top",@"left to right",@"right to left"];
     */
    switch (indexPath.section) {
        case 0:
        {
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
                    
                default:
                    break;
            }
            isPush = NO;
            SecondViewController *two = [[SecondViewController alloc]init];
            two.isPush = isPush;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:two];
            nav.transitioningDelegate = self;
            [self presentViewController:nav animated:YES completion:^{
                
            }];
            
            
        }
            break;
        case 1:
        {
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
                    
                default:
                    break;
            }
            isPush = YES;
            
            SecondViewController *two = [[SecondViewController alloc]init];
            two.isPush = isPush;
            two.transitioningDelegate = self;
            [self.navigationController pushViewController:two animated:YES];
            
            
        }
            break;
        case 2:
        {
            TarBarMainVC *main = [TarBarMainVC new];
            [self presentViewController:main animated:YES completion:^{
                
            }];
            
            
            
        }
            break;
            
        default:
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, 44)];
    header.backgroundColor = [UIColor orangeColor];
    UILabel *ll = [[UILabel alloc]initWithFrame:header.frame];
    ll.textColor = [UIColor blackColor];
    [header addSubview:ll];
    if (section == 0) {
        ll.text = @"模态跳转";
    }else if (section == 2){
        ll.text = @"Push跳转";
    }else{
        ll.text = @"tabBar翻页效果";
    }
    
    return header;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
