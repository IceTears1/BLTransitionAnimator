# BLTransitionAnimator

pod 导入 pod 'BLTransitionAnimation', '~> 1.0.3'

使用方法

1>导入头文件
#import“BLTransitionAnimator.h”

2>跳转方法

//模态跳转
[self BL_presentViewController:nav AnimatorStyle:bl_Type animated:YES];

//push跳转
[self.navigationController BL_pushViewController:vc AnimatorStyle:bl_Type animated:YES];

3>目前只提供了4中+一个自定义的方法  自定义动画应该能满足大部分人的需求
typedef NS_OPTIONS(NSUInteger, BLTransitionAnimatorStyle) {
BLTransitionAnimatorTop= 0,//从顶部滑入
BLTransitionAnimatorLeft, //从左边滑入
BLTransitionAnimatorBottom, //从底部滑入
BLTransitionAnimatorRight,//从右边滑入
BLTransitionAnimatorCustom//自定义动画
};

4>自定义动画位置
//修改内部的方法 对toView 和FromeView进行动画即可
BLDIYTrasitionAnimation.m

5>注意事项
https://github.com/IceTears1/BLTransitionAnimator/blob/master/1457407017129336.gif
Presentation/push 时候
fromView = The presenting view
toView   = The presented view

Dismissal/pop时候

fromView = The presented view.
toView   = The presenting view.
