//
//  YPLoadingButtonView.h
//  btnDemo
//
//  Created by Else on 2019/8/5.
//  Copyright © 2019 YanpengLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPLoadingButtonView : UIView

typedef void(^YPLoadingCallBackBlock)(YPLoadingButtonView *btn);
typedef void(^YPLoadingClickedBlock)(YPLoadingButtonView *btn);

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIView *AnimView;
@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, copy) YPLoadingClickedBlock clickBlock;
@property (nonatomic, copy) YPLoadingCallBackBlock successBlock;

- (void)startAnimate;
- (void)stopAnimate;

@end

NS_ASSUME_NONNULL_END
