//
//  UIButton+wdp_action_style.m
//  HX_GCDTimer
//
//  Created by han xiao on 2020/11/10.
//

#import "UIButton+wdp_action_style.h"
#import <objc/runtime.h>

@implementation UIButton (wdp_action_style)

- (void)setTitlePosition:(TitlePositionType)type spacing:(CGFloat)spacing{
    CGSize imageSize = [self imageForState:self.state].size;
    if (imageSize.height * imageSize.width <= 0) return;
    
    NSString *title = [self titleForState:self.state];
    if (title.length <= 0) return;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    
    switch (type) {
        case TitlePositionLeft:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, 0, imageSize.width + spacing);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing, 0, - titleSize.width);
            break;
        case TitlePositionRight:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
            break;
        case TitlePositionTop:
            self.titleEdgeInsets = UIEdgeInsetsMake(- (imageSize.height + spacing), - imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, - (titleSize.height + spacing), - titleSize.width);
            break;
        case TitlePositionBottom:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height + spacing), 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0, 0, - titleSize.width);
            break;
        default:
            break;
    }
}

- (void)countDownFromTime:(NSInteger)startTime title:(NSString *)title unitTitle:(NSString *)unitTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color isJoin:(BOOL)join{
    
    __weak typeof(self) weakSelf = self;
    
    // 剩余的时间
    __block NSInteger remainTime = startTime;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t  timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    // 子线程（queue）执行event_handler
    dispatch_source_set_event_handler(timer, ^{
        
        if (remainTime <= 0) { // 倒计时结束
            dispatch_source_cancel(timer);
            // 主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = mColor;
                [weakSelf setTitle:title forState:UIControlStateNormal];
                weakSelf.enabled = YES;
            });
        } else {
            NSString *timeStr = [NSString stringWithFormat:@"%ld", remainTime];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = color;
                if (join) {
                   [weakSelf setTitle:[NSString stringWithFormat:@"%@%@%@",title,timeStr,unitTitle] forState:UIControlStateDisabled];
                }else{
                    [weakSelf setTitle:[NSString stringWithFormat:@"%@%@",timeStr,unitTitle] forState:UIControlStateDisabled];
                }
                
                weakSelf.enabled = NO;
            });
            remainTime--;
        }
    });
    dispatch_resume(timer);
}


- (void)setEnlargedEdgeInsets:(UIEdgeInsets)enlargedEdgeInsets{
    NSValue *value = [NSValue valueWithUIEdgeInsets:enlargedEdgeInsets];
    objc_setAssociatedObject(self, @selector(enlargedEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)enlargedEdgeInsets{
    NSValue *value = objc_getAssociatedObject(self, @selector(enlargedEdgeInsets));
    if (value) return [value UIEdgeInsetsValue];
    return UIEdgeInsetsZero;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.enlargedEdgeInsets, UIEdgeInsetsZero)) {
        return [super pointInside:point withEvent:event];
    }
    
    UIEdgeInsets enlarge = UIEdgeInsetsMake(-self.enlargedEdgeInsets.top, -self.enlargedEdgeInsets.left, -self.enlargedEdgeInsets.bottom, -self.enlargedEdgeInsets.right);
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, enlarge);
    return CGRectContainsPoint(hitFrame, point);
}


@end
