//
//  LeftViewController.m
//  TableViewDelegate
//
//  Created by Mac on 2021/4/22.
//  Copyright © 2021 Mac. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self initImageView];
    
    
}

-(void)initImageView{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100,100,100,40)];
//    imageView.image = [UIImage imageNamed:@"myImg"];
    imageView.backgroundColor = [UIColor redColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    // 设置大小
    maskLayer.frame = imageView.bounds;
    // 设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    [self.view addSubview:imageView];
}





@end
