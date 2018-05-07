//
//  ViewController.m
//  XMProgressHUD-master
//
//  Created by 高昇 on 2018/5/7.
//  Copyright © 2018年 xmalt. All rights reserved.
//

#import "ViewController.h"
#import <XMProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction1:(id)sender {
    [XMProgressHUD showInfoText:@"显示文本"];
}
- (IBAction)btnAction2:(id)sender {
    [XMProgressHUD showSuccessText:@"显示成功"];
}
- (IBAction)btnAction3:(id)sender {
    [XMProgressHUD showFailureText:@"显示失败"];
}
- (IBAction)btnAction4:(id)sender {
//    [XMProgressHUD showLoadingText:@"显示加载"];
    [XMProgressHUD showText:@"显示一个文本\n显示一个文本"];
}
- (IBAction)btnAction5:(id)sender {
    [XMProgressHUD hide];
}

@end
