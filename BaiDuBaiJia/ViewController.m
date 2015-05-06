//
//  ViewController.m
//  BaiDuBaiJia
//
//  Created by WayneLiu on 15/4/27.
//  Copyright (c) 2015年 WayneLiu. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+XTSideMenu.h"
#import "XTSideMenu.h"


#import "NewsShowCell.h"
#import "ImageCell.h"
#import "NewsDetailViewController.h"

//static NSString *cellID = @"collectionCell";


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    
    self.headerView.backgroundColor = [UIColor redColor];
    
    [self setupCycleImage];


}
-(void)viewWillLayoutSubviews
{
    //[self showHomeImg];
    //[self setImageSize];
    //[self addImage];
}

-(void)setupCycleImage
{
    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
                        [UIImage imageNamed:@"h2.jpg"],
                        [UIImage imageNamed:@"h3.jpg"],
                        [UIImage imageNamed:@"h4.jpg"]
                        ];
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:self.cycleView.frame imagesGroup:images];
    
    self.cycleView.delegate = self;
    self.cycleView.autoScrollTimeInterval = 2.0;
    [self.view addSubview:self.cycleView];


}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}


#pragma mark - tableView的datasource和delegate方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"NewsShow";
    NewsShowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NewsShowCell" owner:nil options:nil];
    cell = [nib objectAtIndex:0];
    cell.NewsInfo.text = @"百度百家";
    cell.Source.text = @"IT之家";
    cell.NewsPic.image = [UIImage imageNamed:@"2"];
    UIBezierPath* path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(cell.NewsPic.bounds.size.width/2, cell.NewsPic.bounds.size.height/2) radius:cell.NewsPic.bounds.size.width/2-5 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer* shape1 = [CAShapeLayer layer];
    
    shape1.path = path1.CGPath;
    
    cell.NewsPic.layer.mask = shape1;

    
    
    return cell;
}

//跳转到详细新闻界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"newsDetailCell"];
    //[self.navigationController pushViewController:detailVC animated:YES];
    [self presentViewController:detailVC animated:YES completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}



#pragma mark - 展示左边侧滑栏
- (IBAction)showLeftMenu:(UIButton *)sender {
    [self.sideMenuViewController presentLeftViewController];
}

@end
