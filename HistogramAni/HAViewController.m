//
//  HAViewController.m
//  HistogramAni
//
//  Created by duan on 13-7-2.
//  Copyright (c) 2013年 duan. All rights reserved.
//

#import "HAViewController.h"
#import "HAHistogramAni.h"
@interface HAViewController ()
{
    HAHistogramAni *histogramAni;
}
@end

@implementation HAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 20, 60, 25);
    [btn setTitle:@"Show" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showBtn_TouchupInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    histogramAni=[[HAHistogramAni alloc] initWithFrame:CGRectMake(10, 50, 300, 400)];
    [self.view addSubview:histogramAni];
}

-(void)showBtn_TouchupInside
{
    NSArray *dataArr=[NSArray arrayWithObjects:[NSNumber numberWithInt:455],[NSNumber numberWithInt:350],[NSNumber numberWithInt:171],[NSNumber numberWithInt:285],[NSNumber numberWithInt:149],[NSNumber numberWithInt:999], [NSNumber numberWithInt:649],[NSNumber numberWithInt:729],nil];
    [histogramAni showHistogramAni:dataArr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
