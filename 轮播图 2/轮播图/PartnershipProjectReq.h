//
//  PartnershipProjectReq.h
//  轮播图
//
//  Created by 冰泪 on 2017/4/14.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartnershipProjectReq : NSObject
@property(nonatomic,assign)NSInteger company_id;// 	number 	项目id
@property(nonatomic,strong)NSString *cover;// 	string 	项目banner图


@property(nonatomic,strong)NSString *more_url;// 	string 	查看项目更多详情链接
@property(nonatomic,strong)NSString *agreement_url;// 	string 	查看企业合伙协议链接


@property(nonatomic,assign)NSInteger  packid;// 	number 	资产包id 即标id
@property(nonatomic,strong)NSString *title;// 	string 	标名称
@property(nonatomic,assign)float *rate;// 	number 	年化收益率
@property(nonatomic,strong)NSString *repayment_name;// 	string 	计息方式
@property(nonatomic,assign)NSInteger duration;// 	number 	项目期限
@property(nonatomic,strong)NSString *duration_unit;// 	string 	项目期限单位
@property(nonatomic,strong)NSString *status_name;// 	string 	状态名称（进行中、已结束...）
@property(nonatomic,strong)NSString *btn_name;// 	string 	按钮名称（立即认购、认购完成...）
@property(nonatomic,strong)NSString *progress;// 进度
@end
