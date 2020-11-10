//
//  UIButton+wdp_action_style.h
//  HX_GCDTimer
//
//  Created by han xiao on 2020/11/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TitlePositionType) {
    TitlePositionLeft,
    TitlePositionRight,
    TitlePositionTop,
    TitlePositionBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (wdp_action_style)


//增大按钮点击区域
@property (nonatomic,assign) UIEdgeInsets enlargedEdgeInsets;

//有图片有文字的按钮时，设置文字的位置
- (void)setTitlePosition:(TitlePositionType)type spacing:(CGFloat)spacing;
/*
 *  倒计时按钮
 *
 *  @param startTime 倒计时时间
 *  @param title     倒计时结束按钮上显示的文字
 *  @param unitTitle 倒计时的时间单位（默认为s）
 *  @param mColor    按钮的背景色
 *  @param color     倒计时中按钮的背景色
 *  @param join      文字和时间是否拼接在一起
 */
- (void)countDownFromTime:(NSInteger)startTime title:(NSString *)title unitTitle:(NSString *)unitTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color isJoin:(BOOL)join;


@end

NS_ASSUME_NONNULL_END
