# HX_GCDTimer

通过GCD封装实现的timer

当App进入后台后，定时器会自动暂停，为了让定时器一直跑我们需要加上下面代码：

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

使用起来非常简单，导入头文件#import "UIButton+wdp_action_style.h"

在按钮的点击事件中添加如下代码：

[btn countDownFromTime:60 title:@"获取验证码" unitTitle:@"s重新获得" mainColor:[UIColor lightGrayColor] countColor:[UIColor redColor] isJoin:NO];

其他
这个类里面也实现了扩大按钮点击区域，以及实现图片加文字按钮的时候，自定义文字位置
