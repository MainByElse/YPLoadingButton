//
//  ViewController.m
//  YPLoadingButton
//
//  Created by ruanmei on 2019/8/9.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "ViewController.h"
#import "YPLoadingButtonView/YPLoadingButtonView.h"

@interface ViewController ()

@property (nonatomic, strong) YPLoadingButtonView *btnView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.btnView = [[YPLoadingButtonView alloc]initWithFrame:CGRectMake(100, 100, 57, 24)];
    [self.btnView.followBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    [self.btnView.followBtn setBackgroundColor:[UIColor redColor]];
    self.btnView.clickBlock = ^(YPLoadingButtonView * _Nonnull btn) {
        //点击后开始动画并处理网络请求
        [btn startAnimate];
    };
    self.btnView.successBlock = ^(YPLoadingButtonView * _Nonnull btn) {
        //结束时修改按钮为想要的样式
        [btn.followBtn setBackgroundColor:[UIColor lightGrayColor]];
        [btn.followBtn setTitle:@"已关注" forState:UIControlStateNormal];
    };
    [self.view addSubview:self.btnView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //如果加载过程很短，调用结束动画时可以加延迟
    [self.btnView stopAnimate];
}


@end
