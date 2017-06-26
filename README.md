# BLTransitionAnimator
iOS转场动画支持自定义动画简单易用
使用方法
导入头文件
#import“BLTransitionAnimator.h”
使用 
- (void)BL_pushViewController:(UIViewController *)vc AnimatorStyle:(BLTransitionAnimatorStyle)type animated:(BOOL)flag;
 - （void）BL_presentViewController：（UIViewController *）vc AnimatorStyle：（BLTransitionAnimatorStyle）type animated：（BOOL）flag;
跳转使用以上2个方法进行跳转目前仅仅提供了四中转场方式当然预留了自定义的方法可以自己定义转场的动画使用起来更方便



自定义动画位置
BLDIYTrasitionAnimation.m
