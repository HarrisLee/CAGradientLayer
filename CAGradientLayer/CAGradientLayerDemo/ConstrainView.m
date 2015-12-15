//
//  ConstrainView.m
//  CAGradientLayer
//
//  Created by JianRongCao on 15/9/24.
//  Copyright (c) 2015年 JianRongCao. All rights reserved.
//

#import "ConstrainView.h"

@implementation ConstrainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  [UIColor colorWithWhite:0.9 alpha:0.8];
        
        UIView *anima = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2.0, frame.size.height/2.0)];
        anima.tag = 1000;
        anima.backgroundColor = [UIColor blueColor];
        [self addSubview:anima];
        
        UIView *animas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/4.0, frame.size.height/4.0)];
        animas.backgroundColor = [UIColor orangeColor];
        animas.tag = 500;
        [self addSubview:animas];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touches began");
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *subView in [self subviews]) {
        NSLog(@"point1 %@\n   tag -- %ld",subView,subView.tag);
        if (subView.tag == 500) {
//            return NO;
        }
    }
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        NSLog(@"hit1 %@   tag -- %ld",[view nextResponder],view.tag);
        return view ;
    }
    NSLog(@"hit2 %@   tag -- %ld",[view nextResponder],view.tag);
    return view;
}

@end
