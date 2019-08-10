//
//  YPLoadingButtonView.m
//  btnDemo
//
//  Created by Else on 2019/8/5.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import "YPLoadingButtonView.h"

@implementation YPLoadingButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
    
    self.followBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.followBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.followBtn addTarget:self action:@selector(followBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.followBtn];
}

- (void)followBtnClick{
    if (self.clickBlock) {
        self.clickBlock(self);
    }
}

- (void)startAnimate{
    
    self.layer.borderColor = [UIColor clearColor].CGColor;
    
    //禁用用户交互
    self.followBtn.userInteractionEnabled = NO;
    
    //执行登录按钮转圈动画的view
    self.AnimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.AnimView.layer.cornerRadius = self.frame.size.height / 2;
    self.AnimView.layer.masksToBounds = YES;
    self.AnimView.backgroundColor = [UIColor redColor];
    [self addSubview:self.AnimView];
    
    self.followBtn.hidden = YES;
    
    //把view从宽的样子变圆
    CGPoint centerPoint = self.AnimView.center;
    CGFloat radius = MIN(self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.AnimView.frame = CGRectMake(0, 0, radius, radius);
        self.AnimView.center = centerPoint;
        self.AnimView.layer.cornerRadius = radius/2;
        self.AnimView.layer.masksToBounds = YES;
        
    }completion:^(BOOL finished) {
        
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path addArcWithCenter:CGPointMake(radius/2, radius/2) radius:(radius/2 - 5) startAngle:0 endAngle:M_PI_2 * 2 clockwise:YES];
        self.shapeLayer = [[CAShapeLayer alloc] init];
        self.shapeLayer.lineWidth = 1.5;
        self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.fillColor = self.backgroundColor.CGColor;
        self.shapeLayer.frame = CGRectMake(0, 0, radius, radius);
        self.shapeLayer.path = path.CGPath;
        [self.AnimView.layer addSublayer:self.shapeLayer];
        
        //让圆转圈，实现"加载中"的效果
        CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        baseAnimation.duration = 0.4;
        baseAnimation.fromValue = @(0);
        baseAnimation.toValue = @(2 * M_PI);
        baseAnimation.repeatCount = MAXFLOAT;
        [self.AnimView.layer addAnimation:baseAnimation forKey:nil];

    }];
}

- (void)stopAnimate{
    
    if (self.successBlock) {
        self.successBlock(self);
    }
    
    //移除旋转动画
    [self.AnimView.layer removeAllAnimations];
    //移除蒙版
    [self.AnimView removeFromSuperview];
    //隐藏小弧线
    self.shapeLayer.hidden = YES;
    [self.shapeLayer removeFromSuperlayer];
    
    self.followBtn.userInteractionEnabled = YES;
    self.followBtn.hidden = NO;
}

@end
