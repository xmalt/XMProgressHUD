//
//  XMProgressHUD.h
//  XMProgressHUD-master
//
//  Created by 高昇 on 2018/5/7.
//  Copyright © 2018年 xmalt. All rights reserved.
//

#if __has_include(<MBProgressHUD.h>)
#import <MBProgressHUD.h>
#else
#import "MBProgressHUD.h"
#endif

/** 请求状态  */
typedef NS_ENUM(NSInteger, XMProgressHUDStatus) {
    /** 成功 */
    XMProgressHUDStatusSuccess,
    /** 失败 */
    XMProgressHUDStatusError,
    /** 信息 */
    XMProgressHUDStatusInfo,
    /** 加载中 */
    XMProgressHUDStatusWaitting
};

@interface XMProgressHUD : MBProgressHUD

+ (instancetype)sharedHUD;

/**
 弹出一个提示框

 @param status 提示框样式
 @param text 文本
 */
+ (void)showStatus:(XMProgressHUDStatus)status text:(NSString *)text;

/** 在window上添加一个只显示文字的HUD */
+ (void)showText:(NSString *)text;

/**
 显示文本提示

 @param text 文本内容
 @param delay 展示时间
 @param block 关闭提示时的回调
 */
+ (void)showText:(NSString *)text delay:(NSTimeInterval)delay block:(dispatch_block_t)block;

/** 在window上添加一个提示`信息`的HUD */
+ (void)showInfoText:(NSString *)text;
/** 在window上添加一个提示`失败`的HUD */
+ (void)showFailureText:(NSString *)text;
/** 在window上添加一个提示`成功`的HUD */
+ (void)showSuccessText:(NSString *)text;
/** 在window上添加一个提示`加载中`的HUD, 需要手动关闭 */
+ (void)showLoadingText:(NSString *)text;
/** 手动隐藏HUD */
+ (void)hide;

@end
