//
//  BannerView.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "BannerView.h"
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@implementation BannerView
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_imageView;
    NSMutableArray *_ary;
    NSTimer *_timer;
    UILabel *_label;
    NSString *moveDirection;//往左滑动 还是往右滑动
    NSInteger page;//存储页码
    BOOL isMoveBottom; //在移动下边的 scrollow；
}

-(void)initWithCountImageArry:(NSArray *)imagArr jumpBlock:(AdJumpBlock)myBlock refreshUIBlock:(RefreshUIBlock)reBlock{
    self.myBlock = myBlock;
    self.reBlock = reBlock;
    _ary=[[NSMutableArray alloc]initWithArray:imagArr];
    if(_ary.count!=0){
        [self createscrollView];
        if (_ary.count != 1) {
             [self createPageControl];
        }
       
    }
}
-(void)refreshBannerCurPage:(NSInteger)curpage moveDirection:(NSString *)direction{
    NSLog(@"当前页-- %ld--%@-",curpage,direction);
    isMoveBottom = YES;
    CGFloat contentOffset = _scrollView.frame.size.width*(curpage+1);
    //
    if(curpage==(_ary.count-1)){
        //翻到最后一页时  跳转第一页
        if ([direction isEqualToString:@"right"]) {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            
        }else{
            [_scrollView setContentOffset:CGPointMake(contentOffset, 0) animated:YES];
        }
    }else if(curpage==0){
        //翻到第0页时  跳转最后一页
        if ([direction isEqualToString:@"left"]) {
            [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*(_ary.count+1), 0) animated:YES];
            
        }else{
            [_scrollView setContentOffset:CGPointMake(contentOffset, 0) animated:YES];
            
        }
    }else{
        [_scrollView setContentOffset:CGPointMake(contentOffset, 0) animated:YES];
    }
}
- (void)createscrollView
{
    
    int a=(int )_ary.count;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, self.frame.size.height)];
    _scrollView.backgroundColor=[UIColor orangeColor];
    //hight =0  （height<_scrollView.hight）就可以实现 只能左右翻页  不能上下翻页   水平方向也一样
    _scrollView.contentSize=CGSizeMake(_scrollView.bounds.size.width*(a+2), 0);
    
    //设置图片偏移位置
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width,0) animated:NO];
    ////控制翻页  他滑动的是 滚动视图的宽度和高度  整页的翻动
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    //设置超出边界 反弹效果 默认为yes
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:_scrollView];
    
    if (_ary.count == 1) {
        _scrollView.scrollEnabled = NO;
    }else{
        _scrollView.scrollEnabled = YES;
    }
    
    for (int i=0; i<(a+2); i++) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _imageView.userInteractionEnabled=YES;
        _imageView .backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0 blue:(arc4random() % 255)/255.0 alpha:1.0];
        [_scrollView addSubview:_imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height)];
        label.text = [NSString stringWithFormat:@"%c%c",i+96,i+96];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [_imageView addSubview:label];
        //
        //        NSString *ss=nil;
        //        if(i==0){
        //            ss=_ary.lastObject;
        //        }else if(i==(a+1)){
        //            ss=_ary[0];
        //
        //        }else
        //        {
        //            ss=_ary[i-1];
        //        }
        //
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        [_imageView addSubview:btn];
        
    }
}
-(void)Click:(UIButton *)btn
{
    if (self.myBlock) {
        
        //调用block
        self.myBlock([NSString stringWithFormat:@"%ld",btn.tag-100]);
    }
}
-(void)createPageControl
{
    //创建对象
    _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollView.frame.size.height-20,DeviceMaxWidth, 10)];
    //    _pageControl.backgroundColor=[UIColor grayColor];
    //设置 颜色
    _pageControl.pageIndicatorTintColor=[UIColor grayColor];
    //设置当前选中的颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    _pageControl.userInteractionEnabled = NO;
    //设置页数
    _pageControl.numberOfPages=_ary.count;
    //设置居中
    CGSize pointSize = [_pageControl sizeForNumberOfPages:_ary.count];
    // NSLog(@"%f",pointSize.width);
    //NSLog(@"%f",pointSize.height);
    CGFloat page_x =(DeviceMaxWidth/2 - pointSize.width/2);
    //NSLog(@"%f",page_x);
    [_pageControl setFrame:CGRectMake(page_x,_scrollView.frame.size.height-20, pointSize.width, 10)];
    
    
    [self addSubview:_pageControl];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    isMoveBottom = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//        NSLog(@"翻页----%f",_scrollView.contentOffset.x);
    if(_scrollView.contentOffset.x==_scrollView.bounds.size.width*(_ary.count+1)){
        //翻到最后一页时  跳转第一页
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:NO];
    }else if(_scrollView.contentOffset.x==0){
        //翻到第0页时  跳转最后一页
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*_ary.count, 0) animated:NO];
    }
    //获取当前的页码
    _pageControl.currentPage=_scrollView.contentOffset.x/_scrollView.bounds.size.width-1;
    page = _pageControl.currentPage;
    if (page==_ary.count) {
        page=0;
    }else if (page==-1) {
        page=_ary.count-1;
    }else{
        page = _pageControl.currentPage;
    }
    if (!isMoveBottom) {
            if (self.reBlock) {
                //调用block
                self.reBlock(moveDirection,page);
            }
    }
}

////实现scrollView代理
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    //水平滑动时 判断是右滑还是左滑
//    if(velocity.x>0){
//        //右滑
//        moveDirection = @"left";
//    }else{
//        //左滑
//        moveDirection = @"right";
//    }
//    
//}
@end
