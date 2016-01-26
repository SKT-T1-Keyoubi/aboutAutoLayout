//
//  ViewController.m
//  autoLayout
//
//  Created by LoveQiuYi on 16/1/25.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *simpleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *simpleViewTopViewSpaceLayout;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;

@end

@implementation ViewController
CGFloat simpleViewOriginY;
CGFloat simpleViewSpaceLayoutConstant;
CGFloat temp;

- (void)viewDidLoad {
    [super viewDidLoad];
    //为手势添加方法事件
    [self.panGesture addTarget:self action:@selector(pan)];
    //距离顶部的长度->
    temp = self.simpleView.frame.origin.y;
    NSLog(@"%ld",(long)temp);
    //约束
    simpleViewSpaceLayoutConstant = self.simpleViewTopViewSpaceLayout.constant;
    //初始simpleView的位置y
    simpleViewOriginY = temp;
}
//手势动作
- (void) pan{
    //手势动作结束的时候
    if (self.panGesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:5 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            temp = simpleViewOriginY;
        } completion:^(BOOL finished) {
            if (finished) {
                 self.simpleViewTopViewSpaceLayout.constant = simpleViewSpaceLayoutConstant;
            }
        }];
    }
    self.simpleViewTopViewSpaceLayout.constant = simpleViewSpaceLayoutConstant + [self.panGesture translationInView:self.view].y;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
/*autoLayout总结：
 
 
 Apple设备所有的适配基础xib设计在于Any,Any这个模式下的设计
 在这个模式下先把最基础的控件搭配好，位置，布局以及一些基础的约束（这些约束是每种设备上都一样的不需要改变的，也就是baselayout）
 对于横屏的模式选择wAnyHCompact这个模式再在约束上进行调整即可
 对于竖屏的模式选择wCompactHRegular这个模式再进行约束上的调整

 */
