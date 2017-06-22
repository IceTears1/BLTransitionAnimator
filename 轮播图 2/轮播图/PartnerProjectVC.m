
/*
*
* _ooOoo_
* o8888888o
* 88" . "88
* (| -_- |)
*  O\ = /O
* ___/`---'\____
* .   ' \\| |// `.
* / \\||| : |||// \
* / _||||| -:- |||||- \
* | | \\\ - /// | |
* | \_| ''\---/'' | |
* \ .-\__ `-` ___/-. /
* ___`. .' /--.--\ `. . __
* ."" '< `.___\_<|>_/___.' >'"".
* | | : `- \`.;`\ _ /`;.`/ - ` : | |
* \ \ `-. \_ __\ /__ _/ .-` / /
* ======`-.____`-.___\_____/___.-`____.-'======
* `=---='
*          .............................................
*           佛曰：bug泛滥，我已瘫痪！
*/
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "PartnerProjectVC.h"
#import "BannerView.h"
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@interface PartnerProjectVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *bannerAry;
    UIScrollView *_scrollView;
    NSInteger curPage;//用来存储当前展示的tableView 的数据索引
    NSInteger lastIndex;  //上一页的索引
    NSInteger nextIndex;//下一页的索引
    
    NSMutableArray *dataSource0;
    NSMutableArray *dataSource1;
    NSMutableArray *dataSource2;
    
    UITableView *tableView0;
    UITableView *tableView1;
    UITableView *tableView2;
    BannerView *bannerV;
    NSInteger curTableViewTag; //当前显示的tableview 的tag
    NSString *moveDirection;//往左滑动 还是往右滑动
}
@end

@implementation PartnerProjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    NSArray *ary1 = @[@"a",@"a",@"a",@"a"];
    NSArray *ary2 = @[@"b",@"b",@"b",@"b",@"b",@"b"];
    NSArray *ary3 = @[@"c",@"c",@"c",@"c",@"c",@"c",@"c",@"c",@"c"];
    NSArray *ary4 = @[@"d",@"d",@"d",@"d",@"d",@"d"];
    NSArray *ary5 = @[@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e",@"e"];
    NSArray *ary6 = @[@"f",@"f",@"f",@"f",@"f",@"f"];
    
    bannerAry = @[ary1,ary2,ary3,ary4,ary5,ary6];
//    bannerAry = @[ary1,ary2];
    curPage = 0;
    dataSource0 = [[NSMutableArray alloc]init];
    dataSource1 = [[NSMutableArray alloc]init];
    dataSource2 = [[NSMutableArray alloc]init];
    
    
    bannerV = [[BannerView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, 100)];
    bannerV.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bannerV];
    [bannerV initWithCountImageArry:bannerAry jumpBlock:^(NSString *typeId) {
        NSLog(@"%@",typeId);
    } refreshUIBlock:^(NSString *direction, NSInteger page){
        
        NSLog(@"banner 索引------%ld----%@",page,direction);
        curPage = page;
        moveDirection = direction;
        
        NSUInteger last = curPage-1;
        NSUInteger next = curPage+1;
        if (next >= bannerAry.count) {
            next = 0;
        }
        if (last==-1) {
            last = bannerAry.count - 1;
        }
        switch (curTableViewTag) {
            case 0:
            {
                dataSource2 = bannerAry[last];
                dataSource0 = bannerAry[curPage];
                dataSource1 = bannerAry[next];
                
            }
                break;
            case 1:
            {
                dataSource0 = bannerAry[last];
                dataSource1 = bannerAry[curPage];
                dataSource2 = bannerAry[next];
            }
                break;
            case 2:
            {
                dataSource1 = bannerAry[last];
                dataSource2 = bannerAry[curPage];
                dataSource0 = bannerAry[next];
            }
                break;
                
            default:
                break;
        }
        [tableView0 reloadData];
        [tableView1 reloadData];
        [tableView2 reloadData];
    
    }];

    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerV.frame), DeviceMaxWidth, DeviceMaxHeight-CGRectGetMaxY(bannerV.frame))];
    bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bottomView];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth,bottomView.frame.size.height)];
    _scrollView.backgroundColor=[UIColor blueColor];
    //hight =0  （height<_scrollView.hight）就可以实现 只能左右翻页  不能上下翻页   水平方向也一样
    _scrollView.contentSize=CGSizeMake(_scrollView.bounds.size.width*3, 0);
    
    //设置图片偏移位置
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width,0) animated:NO];
    ////控制翻页  他滑动的是 滚动视图的宽度和高度  整页的翻动
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    //设置超出边界 反弹效果 默认为yes
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [bottomView addSubview:_scrollView];
    if (bannerAry.count == 1) {
        _scrollView.scrollEnabled = NO;
    }else{
        _scrollView.scrollEnabled = YES;
    }
    
    tableView0 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, _scrollView.frame.size.height)];
    tableView0.delegate = self;
    tableView0.dataSource = self;
    [_scrollView addSubview:tableView0];
    tableView0.tag = 0;
    
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(DeviceMaxWidth, 0, DeviceMaxWidth, _scrollView.frame.size.height)];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [_scrollView addSubview:tableView1];
    tableView1.tag = 1;
    
    tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(2*DeviceMaxWidth, 0, DeviceMaxWidth, _scrollView.frame.size.height)];
    tableView2.delegate = self;
    tableView2.dataSource = self;
    [_scrollView addSubview:tableView2];
    tableView2.tag = 2;
    curTableViewTag = 1;
    [self refreshDataSource:YES];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",_scrollView.contentOffset.x);
    if(_scrollView.contentOffset.x>=_scrollView.bounds.size.width*2){
        //翻到最后一页时  跳转第一页
        if (curPage>=bannerAry.count-1) {
            curPage = 0;
        }else{
            curPage ++;
        }
        moveDirection = @"left";
        curTableViewTag = curTableViewTag==2?0:curTableViewTag+1;
    }else if(_scrollView.contentOffset.x<=0){
        //翻到第0页时  跳转最后一页
        if (curPage<=0) {
            curPage = bannerAry.count-1;
        }else{
            curPage--;
        }
        moveDirection = @"right";
        curTableViewTag = curTableViewTag==0?2:curTableViewTag-1;
    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     NSLog(@"aaaaaaaa---%ld",curPage);
   
    //获取当前的页码
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:NO];
    [bannerV refreshBannerCurPage:curPage moveDirection:moveDirection];
    [self refreshDataSource:false];
    
   
}
-(void)refreshDataSource:(BOOL)isAllRefresh{
    NSLog(@"刷新数据%ld--  %ld ---%@",curPage,curTableViewTag,moveDirection);
    lastIndex = curPage-1;
    nextIndex = curPage+1;
    if (nextIndex >= bannerAry.count) {
        nextIndex = 0;
    }
    if (lastIndex < 0) {
        lastIndex = bannerAry.count - 1;
    }
    CGRect frame0 = tableView0.frame;
    frame0.origin.x = DeviceMaxWidth * (curTableViewTag==0?1:(curTableViewTag==1?0:2));
    tableView0.frame = frame0;
    
    CGRect frame1 = tableView1.frame;
    frame1.origin.x = DeviceMaxWidth * (curTableViewTag==0?2:(curTableViewTag==1?1:0));
    tableView1.frame = frame1;
    
    CGRect frame2 = tableView2.frame;
    frame2.origin.x = DeviceMaxWidth * (curTableViewTag==0?0:(curTableViewTag==1?2:1));
    tableView2.frame = frame2;

    
    if (isAllRefresh) {
        dataSource0 = bannerAry[lastIndex];
        dataSource1 = bannerAry[curPage];
        dataSource2 = bannerAry[nextIndex];

        [tableView0 reloadData];
        [tableView1 reloadData];
        [tableView2 reloadData];
    }else{
   
        switch (curTableViewTag) {
            case 0:
            {
                if ([moveDirection isEqualToString:@"left"]) {
                    dataSource1 = bannerAry[nextIndex];
                    [tableView1 reloadData];
                }else{
                    dataSource2 = bannerAry[lastIndex];
                    [tableView2 reloadData];
                }
                
            }
                break;
            case 1:
            {
                if ([moveDirection isEqualToString:@"left"]) {
                    dataSource2 = bannerAry[nextIndex];
                    [tableView2 reloadData];
                }else{
                    dataSource0 = bannerAry[lastIndex];
                    [tableView0 reloadData];
                }
            }
                break;
            case 2:
            {
                if ([moveDirection isEqualToString:@"left"]) {
                      dataSource0 = bannerAry[nextIndex];
                    [tableView0 reloadData];
                }else{
                    dataSource1 = bannerAry[lastIndex];
                    [tableView1 reloadData];
                }
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 0:
        {//记录
            return dataSource0.count;
        }
            break;
        case 1:
        {//记录
            return dataSource1.count;
        }
            break;
        default:{
            return dataSource2.count;
        }
            break;
    }

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"BgCell";
    UITableViewCell *bgCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (bgCell == nil) {
        bgCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    bgCell.textLabel.textAlignment = NSTextAlignmentCenter;
    bgCell.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0  blue:240/255.0  alpha:1];
    bgCell.selectionStyle = UITableViewCellSelectionStyleNone;
    //标题cell
//    NSLog(@"刷新tableview-tag-%ld",tableView.tag);
    switch (tableView.tag) {
        case 0:
        {//记录
            
            bgCell.textLabel.text = dataSource0[indexPath.row];
            return bgCell;
        }
            break;
        case 1:
        {//记录
            bgCell.textLabel.text = dataSource1[indexPath.row];
//            bgCell.backgroundColor = [UIColor redColor];
            return bgCell;
        }
            break;
        default:{
            bgCell.textLabel.text = dataSource2[indexPath.row];
            return bgCell;
        }
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
        {//记录
            return 50;
        }
            break;
        case 1:
        {//记录
            return 50;
        }
            break;
        default:{
            return 50;
        }
            break;
    }

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
        {//记录
            
        }
            break;
        case 1:
        {//记录
        
        }
             break;
        default:{
            
        }
            break;
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
