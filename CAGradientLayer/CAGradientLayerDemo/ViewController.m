//
//  ViewController.m
//  CAGradientLayer
//
//  Created by JianRongCao on 15/8/21.
//  Copyright (c) 2015年 JianRongCao. All rights reserved.
//

#import "ViewController.h"
#import "ConstrainView.h"
#import <objc/runtime.h>

#define kHostUrl @"http://192.168.1.104:8088"
#define kScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen] bounds].size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    ConstrainView *viewContrain = [[ConstrainView alloc] initWithFrame:CGRectMake(20, 50, kScreenWidth - 40, 150)];
//    [self.view addSubview:viewContrain];

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,
                             (__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor
                             ];   //渐变的三种颜色，可以多种
    gradientLayer.locations = @[@0.1,@0.5,@0.8];  //每种颜色所占比例
    gradientLayer.startPoint = CGPointMake(0, 0);  //开始点
    gradientLayer.endPoint = CGPointMake(0.5, 1.0);//结束点   当不为（0，1）或者（1，0）时，可以实现倾斜效果
    [self.view.layer addSublayer:gradientLayer];

    CAShapeLayer *indefiniteAnimatedLayer = [CAShapeLayer layer];
    indefiniteAnimatedLayer.frame = CGRectMake(100, 100, 100, 100);
    indefiniteAnimatedLayer.fillColor = [UIColor clearColor].CGColor;    //填充颜色
    indefiniteAnimatedLayer.strokeColor = [UIColor brownColor].CGColor;   //描边颜色
    indefiniteAnimatedLayer.lineCap = kCALineCapRound;    //线条折角是圆形还是直线结尾
    indefiniteAnimatedLayer.lineWidth = 10.0;  //线的宽度
    indefiniteAnimatedLayer.opacity = 0.8;    //Layer的透明度
    indefiniteAnimatedLayer.lineJoin = kCALineJoinRound;   ////终点处理方式
    indefiniteAnimatedLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:40
                                           startAngle:0
                                             endAngle:1.4*M_PI
                                            clockwise:YES].CGPath;
    
    
    CALayer *maskContent = [CALayer layer];
    maskContent.contents = (id)[UIImage imageNamed:@"angle-mask"].CGImage;
    maskContent.frame = indefiniteAnimatedLayer.bounds;
    indefiniteAnimatedLayer.mask = maskContent;
    
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth-40, kScreenHeight)];
//    animation.duration = 3.0;
//    animation.repeatCount = HUGE_VAL;
//    [indefiniteAnimatedLayer addAnimation:animation forKey:@"move"];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = 0;
    rotation.toValue = [NSNumber numberWithFloat:M_PI*2];
    rotation.duration = 1.5;
    rotation.repeatCount = HUGE_VAL;
//    [indefiniteAnimatedLayer addAnimation:rotation forKey:@"rotation"];
    
    
    //这样可以使圆环看起来在逐渐变短   看起来有点类似于进度条减小
    NSTimeInterval animationDuration = 3;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = animationDuration;
    animationGroup.repeatCount = INFINITY;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = linearCurve;
    
    //动画开始时，划线的长度
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @0.015;
    strokeStartAnimation.toValue = @0.915;
    
    //动画结束时，划线的长度
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0.785;
    strokeEndAnimation.toValue = @0.885;
    
    animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation,rotation];
    [indefiniteAnimatedLayer addAnimation:animationGroup forKey:@"progress"];
//
    [self.view.layer addSublayer:indefiniteAnimatedLayer];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"super touch");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
