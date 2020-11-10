//
//  ViewController.m
//  HX_GCDTimer
//
//  Created by han xiao on 2020/11/10.
//

#import "ViewController.h"
#import "UIButton+wdp_action_style.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GCDTimer";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100,200,100,44)];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [btn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getVerificationCode:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btn];
 
}
//获取验证码
- (void)getVerificationCode:(UIButton *)btn{
    [btn countDownFromTime:60 title:@"获取验证码" unitTitle:@"s重新获得" mainColor:[UIColor lightGrayColor] countColor:[UIColor redColor] isJoin:NO];
}

@end
