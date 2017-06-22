//
//  BannerView.h
//  轮播图
//
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AdJumpBlock)(NSString *typeId);
typedef void (^RefreshUIBlock)(NSString *direction,NSInteger page);
@interface BannerView : UIView<UIScrollViewDelegate>
-(void)initWithCountImageArry:(NSArray *)imagArr jumpBlock:(AdJumpBlock)myBlock refreshUIBlock:(RefreshUIBlock) reBlock;

@property (nonatomic, copy) AdJumpBlock myBlock;
@property (nonatomic, copy) RefreshUIBlock reBlock;
- (void)refreshBannerCurPage:(NSInteger)curpage moveDirection:(NSString*) direction;
@end
