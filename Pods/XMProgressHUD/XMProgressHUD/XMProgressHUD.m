//
//  XMProgressHUD.m
//  XMProgressHUD-master
//
//  Created by 高昇 on 2018/5/7.
//  Copyright © 2018年 xmalt. All rights reserved.
//

#import "XMProgressHUD.h"

// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE 13.0f

@interface XMProgressHUD ()

/* window */
@property(nonatomic, strong)UIWindow *window;

@end

@implementation XMProgressHUD

+ (instancetype)sharedHUD
{
    static XMProgressHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.windowLevel = UIWindowLevelAlert;
        window.backgroundColor = [UIColor clearColor];
        window.rootViewController = [UIViewController new];
        window.rootViewController.view.backgroundColor = [UIColor clearColor];
        
        hud = [[XMProgressHUD alloc] initWithView:window.rootViewController.view];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        hud.contentColor = [UIColor whiteColor];
        hud.window = window;
        hud.completionBlock = ^{
            hud.window.hidden = YES;
        };
    });
    return hud;
}

+ (void)showStatus:(XMProgressHUDStatus)status text:(NSString *)text
{
    XMProgressHUD *hud = [XMProgressHUD sharedHUD];
    [hud showAnimated:YES];
    /** 内容  */
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    hud.window.hidden = NO;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *lastWindow = (UIWindow *)[windows lastObject];
    [hud.window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    hud.window.windowLevel = lastWindow.windowLevel+1;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 11.0, *)) {
            if ([lastWindow isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]) {
                [lastWindow addSubview:hud];
            }else {
                [hud.window addSubview:hud];
            }
        } else {
            [hud.window addSubview:hud];
        }
    });
    hud.userInteractionEnabled = NO;
    __weak __typeof(&*hud) weakHud = hud;
    hud.completionBlock = ^{
        [weakHud removeFromSuperview];
        weakHud.window.hidden = YES;
    };
    
    switch (status) {
        case XMProgressHUDStatusSuccess:
        {
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:[self imagesNamedFromCustomBundle:@"hud_success"]];
            hud.customView = sucView;
            [hud hideAnimated:YES afterDelay:1.0f];
        }
            break;
        case XMProgressHUDStatusError:
        {
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:[self imagesNamedFromCustomBundle:@"hud_error"]];
            hud.customView = errView;
            [hud hideAnimated:YES afterDelay:1.0f];
        }
            break;
        case XMProgressHUDStatusWaitting:
        {
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
        case XMProgressHUDStatusInfo:
        {
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:[self imagesNamedFromCustomBundle:@"hud_info"]];
            hud.customView = errView;
            [hud hideAnimated:YES afterDelay:1.0f];
        }
            break;
        default:
            break;
    }
}

+ (void)showText:(NSString *)text
{
    [self showText:text block:nil];
}

+ (void)showText:(NSString *)text block:(dispatch_block_t)block
{
    [self showText:text delay:1.0f block:block];
}

+ (void)showText:(NSString *)text delay:(NSTimeInterval)delay block:(dispatch_block_t)block
{
    XMProgressHUD *hud = [XMProgressHUD sharedHUD];
    [hud showAnimated:YES];
    /** 内容  */
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:TEXT_SIZE];
    [hud setMinSize:CGSizeZero];
    [hud setMode:MBProgressHUDModeText];
    [hud setRemoveFromSuperViewOnHide:YES];
    hud.window.hidden = NO;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *lastWindow = (UIWindow *)[windows lastObject];
    [hud.window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    hud.window.windowLevel = lastWindow.windowLevel+1;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 11.0, *)) {
            if ([lastWindow isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]) {
                [lastWindow addSubview:hud];
            }else {
                [hud.window addSubview:hud];
            }
        } else {
            [hud.window addSubview:hud];
        }
    });
    __weak __typeof(&*hud) weakHud = hud;
    hud.completionBlock = ^{
        [weakHud removeFromSuperview];
        weakHud.window.hidden = YES;
    };
    [hud hideAnimated:YES afterDelay:delay];
    
    /** 隐藏回调  */
    if (block) {
        [hud setCompletionBlock:^(){
            block();
        }];
    }
}

+ (void)showInfoText:(NSString *)text
{
    [self showStatus:XMProgressHUDStatusInfo text:text];
}

+ (void)showFailureText:(NSString *)text
{
    [self showStatus:XMProgressHUDStatusError text:text];
}

+ (void)showSuccessText:(NSString *)text
{
    [self showStatus:XMProgressHUDStatusSuccess text:text];
}

+ (void)showLoadingText:(NSString *)text
{
    [self showStatus:XMProgressHUDStatusWaitting text:text];
}

+ (void)hide
{
    [[XMProgressHUD sharedHUD] hideAnimated:YES];
}

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imageName
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"resource" ofType:@"bundle"];
    return [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:imageName]];
}

@end
